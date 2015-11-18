import numpy as np
import matplotlib.pyplot as plt

import zipfile
import pandas

# Import the data
print('Importing...')
zipped = zipfile.ZipFile('data/taxirides.csv.zip')
file_list = zipped.namelist()
file_in_archive = file_list[0]

with zipped.open(file_list[0]) as f:
    data = pandas.read_csv(f)


def calculate_median_mad(values):
    median = np.median(values)
    mad = np.median(abs(values - median))
    return median, mad

print('Calculating...')

med_long, mad_long = calculate_median_mad(data.pickup_longitude)
std_long = np.std(data.pickup_longitude)

med_long, mad_long = calculate_median_mad(data.pickup_longitude)
long_lo = med_long - 20*mad_long
long_hi = med_long + 20*mad_long

med_lat, mad_lat = calculate_median_mad(data.pickup_latitude)
lat_lo = med_lat - 10*mad_lat
lat_hi = med_lat + 10*mad_lat

nwr = [40.69, -74.174]
jfk = [40.641, -73.778]
lga = [40.777, -73.874]

airports = np.array([nwr, jfk, lga])
airport_lat, airport_long = airports.T

print('Plotting...')

fig, ax = plt.subplots()

ax.plot(airport_long, airport_lat, 'go', alpha=0.2)
ax.plot(data.dropoff_longitude, data.dropoff_latitude, 'k,')
# ax.plot(data.pickup_longitude, data.pickup_latitude, 'r,')

ax.axis('scaled')

ax.set_xlim(long_lo, long_hi)
ax.set_ylim(lat_lo, lat_hi)

fig.savefig('data/taxiplot.png', dpi=200)
print('Done.')
