#! /usr/bin/python3

from datetime import date
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import psutil as ps
from scipy.stats import linregress


filename = "/home/josh/scripts/disk_usage.csv"

drive_data = {"Date":date.today().strftime("%Y-%m-%d"),"date_ordinal":date.today().toordinal()}
drives = ["/mnt/disk1", "/mnt/disk2", "/mnt/disk3", "/mnt/storage", "/mnt/parity"]

for drive in drives:
    drive_data[drive.split("/")[2]] = round(ps.disk_usage(drive).used / (1024 ** 3), 2)

df = pd.read_csv(filename)
df_tmp = pd.DataFrame(drive_data,index=[len(df)])
df = pd.concat([df,df_tmp])
df.to_csv(filename,index=False)

rows, cols = df.shape

fig, ax = plt.subplots(figsize=(9, 7))
for i in range(2,len(df.columns)):
        plt.plot(df.iloc[:,0], df.iloc[:,i], linestyle='-', label=df.columns.values[i])

plt.title("Disk Usage Over Time")
plt.xlabel("Date")
plt.ylabel("Space Used (GB)")
plt.legend(loc='upper left', ncols=5)
ax.xaxis.set_major_locator(plt.MaxNLocator(3))

# Linear regression
slope, intercept, _, _, _ = linregress(df.loc[:,"date_ordinal"], df.loc[:,"storage"])
regression_line = slope * df.loc[:,"date_ordinal"] + intercept
plt.plot(df.loc[:,"Date"], regression_line, linestyle='--', color='black', label='Linear Regression')

days_left = int((ps.disk_usage("/mnt/storage").free  / (1024 ** 3)) / slope)
date_full = date.fromordinal(date.today().toordinal()+days_left)

plt.annotate('Date full: %s' %date_full, xy=(19/1/2024, df.loc[:,"storage"].max()+400), annotation_clip=False)
plt.savefig("/mnt/storage/disk_capacity_plot.png")
plt.show()
