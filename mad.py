import numpy as np


def median_mad(values):
    "Calculate the median and the median absolute deviation"
    median = np.median(values)
    mad = np.median(np.abs(values - median))
    return median, mad
