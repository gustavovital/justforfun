from matplotlib.backends.backend_agg import FigureCanvasAgg as FigureCanvas # FigureCanvas
from matplotlib.figure import Figure # import figure artist
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
from __future__ import print_function

# example one
fig = Figure()
canvas = FigureCanvas(fig)

x = np.random.randn(10000)

ax = fig.add_subplot(111)
ax.hist(x, 100)

# add title
ax.set_title("Normal distribution with $\mu=0, \sigma=1$")
fig.savefig("D:\\Just for Fun\\Python\\Data Visualization with Python\\matplotlib_histogram.png")

# using pyplot
x = np.random.randn(10000)
plt.hist(x, 100)
plt.title("Normal distribution with $\mu=0, \sigma=1$")
plt.show()

# Basic Plotting with Matplotlib ####

plt.plot(5, 5, 'o')
plt.xlabel("X")
plt.ylabel("Y")
plt.title("Plotting example")

plt.show()

# dataset

df_can = pd.read_excel(
    "D:\\Just for Fun\\Python\\Data Visualization with Python\\Canada.xlsx",
    sheet_name="Canada by Citizenship",
    skiprows=range(20),
    skipfooter=2
)

df_can.head()
df_can.reindex("OdName")