import re, unidecode
from nltk.corpus import stopwords
from nltk.stem import SnowballStemmer

SW = stopwords.words('english')
STEMMER = SnowballStemmer('english')

def clean_tokenizer(text):
    return [
        STEMMER.stem(
            unidecode.unidecode(w)
            ) for w in re.findall(
                r'[a-z]+',re.sub(
                    r'[^a-z ]',
                    r'',
                    text.lower()             
                    )
                ) 
        if w not in SW
        ]