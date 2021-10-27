import matplotlib.pyplot as plt
import numpy as np

x = np.linspace(0,5,11)
y = x**2

# forma funcional
plt.plot(x, y, 'r--')
plt.xlabel("Eixo X")
plt.ylabel("Eixo Y")
plt.title("Título")
plt.show()

# subplots
plt.subplot(1, 2, 1)  # linha coluna e o primeiro elemento
plt.plot(x, y, 'r--')

plt.subplot(1, 2, 2)
plt.plot(y, x, 'g*--')
plt.show()

# acessando instancias
fig = plt.figure()

ax1 = fig.add_axes([.1, .1, .8, .8])
ax2 = fig.add_axes([.2, .5, .3, .3])

ax1.plot(x, y)
ax1.set_xlabel("Eixo X")
ax1.set_title("Título")

ax2.plot(y, x)
plt.show()

# instancias a partir de subplots
fig, ax = plt.subplots()

ax.plot(x, x**3, 'b--')
ax.plot(x, x**4, 'g--')
ax.set_xlabel("Eixo X")
ax.set_ylabel("Eixo Y")
ax.set_title("Título")

plt.show()

#

fig2, ax = plt.subplots(1, 2)

for axe in ax:
    axe.plot(x, y)
    axe.set_title("Título")

plt.show()

# Ou ainda:
fig2, ax = plt.subplots(1, 2)

ax[0].plot(x, y)
ax[0].set_title("Título")
ax[1].plot(x, y)
ax[1].set_title("Título")
plt.show()

# Tight

fig3, ax = plt.subplots(5, 5)
plt.tight_layout()

for axe in ax:
    axe.plot(x, y)
    axe.set_title("Título")

plt.show()

# add legendas

fig4, axes = plt.subplots()

axes.plot(x, y, 'r--', label='x^2')
axes.plot(y, x, 'g--', label='x^1/2')
axes.legend()
axes.set_title("Título")

plt.show()
