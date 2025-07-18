import requests
import os

START_EVEN = 3
START_ASCII = 68

for i in range(1,7):
    yy, cl = 2*(i + START_EVEN) - 1, chr(START_ASCII + i)
    folder, dem, bio, cbc = f'20{str(yy).zfill(2)}-20{str(yy+1).zfill(2)}', f'DEMO_{cl}', f'BIOPRO_{cl}', f'CBC_{cl}'
    os.makedirs(folder)

    for file in [dem, bio, cbc]:
        path = os.path.join(folder,file + '.xpt')
        response = requests.get(f'https://wwwn.cdc.gov/Nchs/Data/Nhanes/Public/20{str(yy).zfill(2)}/DataFiles/{file}.xpt')
        response.raise_for_status()

        with open(path,'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)