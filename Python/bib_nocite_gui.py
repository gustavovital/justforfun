import tkinter as tk

app = tk.Tk()

app.title(".bib para \\nocite")
button = tk.Button(app, text="Stop", width = 25, command = app.destroy)
button.pack()

app.mainloop()