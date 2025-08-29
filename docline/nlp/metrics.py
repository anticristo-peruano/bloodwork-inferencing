import difflib
import numpy as np
from scipy.optimize import linear_sum_assignment
from .preprocess import clean_tokenizer


def common_substring(a,b,threshold):
    la, lb = list(a), list(b)
    sm = difflib.SequenceMatcher(autojunk=False)
    results = []

    while True:
        sa, sb = ''.join(ch if ch is not None else "\x00" for ch in la), ''.join(ch if ch is not None else "\x01" for ch in lb)
        sm.set_seqs(sa,sb)
        i, j, L = sm.find_longest_match(0, len(sa), 0, len(sb))
        if L < threshold:
            break
        results.append((i, j, L))
        for k in range(L):
            la[i + k] = None
            lb[j + k] = None
    return results

def stoilos_similarity(s1,s2,p = 0.6,substring_threshold = 2,prefix_scale = 0.1,max_prefix = 4):
    s1, s2 = ''.join(clean_tokenizer(s1)), ''.join(clean_tokenizer(s2))
    if not s1 and not s2: return 1.0
    if not s1 or not s2: return 0.0

    lcs = sum(L for _,_,L in common_substring(s1,s2,threshold=substring_threshold))
    comm = 2.0 * lcs / (len(s1) + len(s2))

    u1, u2 = max(0.0, (len(s1) - lcs) / len(s1)), max(0.0, (len(s2) - lcs) / len(s2))
    denom = p + (1.0 - p) * (u1 + u2 - u1 * u2)
    diff = 0.0 if denom == 0 else (u1 * u2)/denom

    Lprefix = 0
    for ca, cb in zip(s1, s2):
        if ca == cb:
            Lprefix += 1
            if Lprefix >= max_prefix: break
        else:
            break
    winkler = Lprefix * prefix_scale * (1.0 - comm)

    sim = comm - diff + winkler
    return -1.0 if sim < -1.0 else (1.0 if sim > 1.0 else sim)

def pairwise_matrix (tokens1, tokens2):
    m, n = len(tokens1), len(tokens2)
    M = np.zeros((m, n), dtype=float)
    for i, ta in enumerate(tokens1):
        for j, tb in enumerate(tokens2):
            M[i, j] = stoilos_similarity(ta, tb)
    return M

def soft_jaccard_bow (s1,s2,sim_thres = 0.8):
    s1, s2 = clean_tokenizer(s1), clean_tokenizer(s2)
    if not s1 and not s2: return 1.0
    if not s1 or not s2: return 0.0

    M = pairwise_matrix(s1,s2)
    C = 1.0 - np.where(M >= sim_thres, M, 0.0)

    m, n = C.shape
    if m > n:
        C = np.hstack([C, np.ones((m, m-n))])
    elif n > m:
        C = np.vstack([C, np.ones((n-m, n))])

    rows, cols = linear_sum_assignment(C)
    s = 0.0
    for r, c in zip(rows, cols):
        if r < M.shape[0] and c < M.shape[1]:
            val = M[r, c]
            if val >= sim_thres:
                s += float(val)

    denom = len(s1) + len(s2) - s
    return 0.0 if denom <= 0 else s / denom

def combined_similarity(s1,s2,p = 0.7,sim_thres = 0.8):
    st = stoilos_similarity(s1,s2)
    bw = soft_jaccard_bow(s1, s2, sim_thres = sim_thres)
    sim = p * st + (1 - p) * bw
    return -1.0 if sim < -1.0 else (1.0 if sim > 1.0 else sim)

def confidence_score(s1,s2,p = 0.7, floor = 0.15, ceil = 1.0, sim_thres = 0.8):
    sim = combined_similarity(s1, s2, p=p, sim_thres=sim_thres)
    if ceil <= floor:
        return int(round(1000 * sim))
    scaled = (sim - floor) / (ceil - floor)
    scaled = 0.0 if scaled < 0.0 else (1.0 if scaled > 1.0 else scaled)
    return int(round(1000 * scaled))
