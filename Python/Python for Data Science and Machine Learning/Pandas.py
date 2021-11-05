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

# data frame

np.random.seed(101)

df = pd.DataFrame(np.random.randn(5, 4), index="A B C D E".split(), columns="W X Y Z".split())
df["new"] = df["W"] + df["X"]
# df.head()
df.drop("new", axis=1, inplace=True)

# df.loc["A", "W"]
# df.iloc[0,0]  # atenção nesse

