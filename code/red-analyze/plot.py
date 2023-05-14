import matplotlib.pyplot as plt
import argparse

parser = argparse.ArgumentParser(description='Draw matplotlib plots')
parser.add_argument('filename')
args = parser.parse_args()
with open(args.filename, 'r') as f:
    lines = f.readlines()
    x = [float(line.split()[0]) for line in lines]
    y = [float(line.split()[1]) for line in lines]
plt.plot(x ,y, color="black")
plt.show()
