import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from sklearn.preprocessing import StandardScaler

df = pd.read_csv("Python\\Python for Data Science and Machine Learning\\Classified Data", index_col=0)
# print(df.head(3))
# print(df.columns)

scaler = StandardScaler()  # define the standart form z = (x-u)/s
