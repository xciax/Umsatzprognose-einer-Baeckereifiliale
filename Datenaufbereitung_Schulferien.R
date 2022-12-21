# Schulferien im Format YYYY-MM-DD
# 2013 bis 2020
schulferien_dates <- c(seq(as.Date("2013-03-25"), as.Date("2013-04-09"), by = "days"),
                 seq(as.Date("2013-06-24"), as.Date("2013-08-03"), by = "days"),
                 as.Date("2013-05-10"), 
                 seq(as.Date("2013-10-04"), as.Date("2013-10-18"), by = "days"),
                 seq(as.Date("2013-12-23"), as.Date("2014-01-06"), by = "days"), 
                 seq(as.Date("2014-04-16"), as.Date("2014-05-14"), by = "days"),
                 as.Date("2014-05-30"),
                 seq(as.Date("2014-07-14"), as.Date("2014-08-23"), by = "days"),
                 seq(as.Date("2014-10-13"), as.Date("2014-10-25"), by = "days"),
                 seq(as.Date("2014-12-22"), as.Date("2015-01-06"), by = "days"),
                 seq(as.Date("2015-04-01"), as.Date("2015-04-17"), by = "days"),
                 as.Date("2015-05-15"),
                 seq(as.Date("2015-07-20"), as.Date("2015-08-29"), by = "days"),
                 seq(as.Date("2015-10-19"), as.Date("2015-10-31"), by = "days"),
                 seq(as.Date("2015-12-21"), as.Date("2016-01-06"), by = "days"),
                 seq(as.Date("2016-03-24"), as.Date("2016-04-16"), by = "days"),
                 as.Date("2016-05-16"),
                 seq(as.Date("2016-07-25"), as.Date("2016-09-03"), by = "days"),
                 seq(as.Date("2016-10-17"), as.Date("2016-10-29"), by = "days"),
                 seq(as.Date("2016-12-23"), as.Date("2017-01-06"), by = "days"),
                 seq(as.Date("2017-04-07"), as.Date("2017-04-21"), by = "days"),
                 as.Date("2017-05-26"),
                 seq(as.Date("2017-07-24"), as.Date("2017-09-02"), by = "days"),
                 seq(as.Date("2017-10-16"), as.Date("2017-10-27"), by = "days"),
                 seq(as.Date("2017-12-21"), as.Date("2018-01-06"), by = "days"),
                 seq(as.Date("2018-03-29"), as.Date("2018-04-13"), by = "days"),
                 as.Date("2018-05-11"),
                 seq(as.Date("2018-07-09"), as.Date("2018-08-18"), by = "days"),
                 seq(as.Date("2018-10-01"), as.Date("2018-10-19"), by = "days"),
                 seq(as.Date("2018-12-21"), as.Date("2019-01-04"), by = "days"),
                 seq(as.Date("2019-04-04"), as.Date("2019-04-18"), by = "days"),
                 as.Date("2019-05-31"),
                 seq(as.Date("2019-07-01"), as.Date("2019-08-10"), by = "days"),
                 seq(as.Date("2019-10-04"), as.Date("2019-10-18"), by = "days"),
                 seq(as.Date("2019-12-23"), as.Date("2020-01-06"), by = "days"))
                 
                 
schulferien <- data.table(Datum = schulferien_dates,
                          Schulferien = 1)             

save(schulferien, file = "schulferien.Rda")                 


