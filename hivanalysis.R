rawdata = read.csv("hivprevalence.csv")
countries = rawdata[1]
hivrates = rawdata[-1]
data = t(hivrates)
colnames(data) = countries[-1]
timeseries = ts(hivrates, start = 1975, end = 2011)
