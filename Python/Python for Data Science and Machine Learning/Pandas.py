import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

labels = ['a', 'b', 'c']
minha_lista = [10, 20, 30]
arr = np.array([10, 20, 30])
d = {"a":10, "b":20, "c":30}

series = pd.Series(data=minha_lista, index=labels)

ser1 = pd.Series([1, 2, 3, 4], index=['EUA', 'Alemanha', 'URSS', 'Japao'])
ser2 = pd.Series([1, 2, 3, 4], index=['EUA', 'Alemanha', 'Italia', 'Japao'])

print(ser1 + ser2)