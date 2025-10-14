import sys
import numpy as np
from PIL import Image

data = Image.open(sys.argv[1])
data = data.resize((640, 480))

data = data.convert("P", palette=Image.ADAPTIVE, colors=256, dither=1)

data_ar = np.array(data).reshape(-1)
colors = palette = np.array(data.getpalette(),dtype=np.uint8).reshape((256,3))

#print(colors)
#print(np.unique(np.array(data)))
#print(data.getcolors())

with open('index_logo.mif', 'w+') as f:
    f.write(f'''WIDTH = 24;
DEPTH = {len(colors)};

ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;

CONTENT BEGIN\n''')
    for i in range(len(colors)):
        f.write(
            f'{i:0X}:{colors[i][0]:02X}{colors[i][1]:02X}{colors[i][2]:02X};\n')
    f.write('END;\n')

with open('img_data_logo.mif', 'w+') as f:
    f.write(f'''WIDTH = 8;
DEPTH = {len(data_ar)};

ADDRESS_RADIX = HEX;
DATA_RADIX = HEX;

CONTENT BEGIN\n''')
    for i in range(len(data_ar)):
        f.write(
            f'{i:0X}:{data_ar[i]:02X};\n')
    f.write('END;\n')

data.save('out.png')
