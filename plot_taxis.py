import numpy as np
import matplotlib.pyplot as plt
import zipfile
from numpy import array
import pandas

from mad import median_mad

zipped = zipfile.ZipFile('data/taxirides.csv.zip')

file_list = zipped.namelist()
file_in_archive = file_list[0]

with zipped.open(file_list[0]) as f:
    data = pandas.read_csv(f)

median, mad = median_mad(data.pickup_longitude)

long_lo = median - 20*mad
long_hi = median + 20*mad

median, mad = median_mad(data.pickup_latitude)
lat_lo = median - 10*mad
lat_hi = median + 10*mad

plt.subplots(figsize=(4, 3))
plt.plot(data.dropoff_longitude,
         data.dropoff_latitude, 'k,')
plt.axis('scaled')
plt.xlim(long_lo, long_hi)
plt.ylim(lat_lo, lat_hi)

# Added this line, so we can save the plot!
plt.savefig('taxi_rides.png', dpi=200)
