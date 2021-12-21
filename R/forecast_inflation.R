

# Packages ----
library(BETS)
library(mFilter)
library(vars)

rm(list=ls())


# Get variables ----
m1 <- BETSget(27841)
m2 <- BETSget(27842)
m3 <- BETSget(27813)
ipca <- BETSget(433)
cambio <- BETSget(11753)
r_lp <- BETSget(256)
i_cp <- BETSget(4390)
ipc <- BETSget(191)
ibcbr <- BETSget(24364)
u <- BETSget(28763)

# wrangling ----
m1 <- ts(m1$value, start = c(2001,12), frequency = 12)
m2 <- ts(m2$value, start = c(2001,12), frequency = 12)
m3 <- ts(m3$value, start = c(1988,07), frequency = 12)
ipca <- ts(ipca, start = c(1980,01), frequency = 12)
cambio <- ts(cambio$value, start = c(1988,01), frequency = 12)
r_lp <- ts(r_lp$value, start = c(1994,12), frequency = 12)
i_cp <- ts(i_cp$value, start = c(1986,06), frequency = 12)
ipc <- ts(ipc$value, start=c(1990, 01), frequency = 12)
ibcbr <- ts(ibcbr$value, start=c(2003,01), frequency = 12)
u <- ts(u$value, start=c(1992,01), frequency = 12)

# Hp filter ----
gap <- hpfilter(ibcbr)
gap <- gap$cycle

u_gap <- hpfilter(u)
u_gap <- u_gap$cycle

#  relative changes and window ----
m1 <- window(diff((m1)), start=c(2003,01), end=c(2021,10))
m2 <- window(diff((m2)), start=c(2003,01), end=c(2021,10))
m3 <- window(diff((m3)), start=c(2003,01), end=c(2021,10))
ipca <- window(ipca, start=c(2003,01), end=c(2021,10))
cambio <- window(cambio, start=c(2003,01), end=c(2021,10))
r_lp <- window(r_lp, start=c(2003,01), end=c(2021,10))
i_cp <- window(i_cp, start=c(2003,01), end=c(2021,10))
ipc <- window(ipc, start=c(2003,01), end=c(2021,10))
gap <- window(gap, start=c(2003,01), end=c(2021,10))
u_gap <- window(u_gap, start=c(2003,01), end=c(2021,10))

data <- ts(data.frame(m1, m2, m3, ipc, ipca, cambio, r_lp, i_cp, gap, u_gap),
           start = c(2012, 01), frequency = 12)

# Estimating VAR ----
# detach("package:BETS", unload = TRUE)
VAR(data, p=2)
predict(VAR(data, p=2))
VARselect(data)

var01 <- VAR(data, p = 4)
predict01 <- predict(var01, n.ahead=12)

x11(); par(mai=rep(0.4,4)); plot(predict01)
x11(); par(mai=rep(0.4,4)); fanchart(predict01)

# recover lev forecast
m.varf_lev_ft <- rbind(data, matrix(NA, 12, 10))
m.ft_df <- do.call(cbind,lapply(predict01$fcst, function(x) x[,"fcst"]))

# growth to level
for(h in (nrow(data)+1):(nrow(data)+12)) {
  hf <- h - data
  m.varf_lev_ft[h,] <-  m.varf_lev_ft[h - 1,] + m.ft_df[hf,]
}

# Draw Graph
x11(width=8, height = 8); 
par(mfrow=c(4,1), mar=c(2,2,2,2))

for(i in 1:4) {
  df <- m.varf_lev_ft[,i]
  matplot(df, type=c("l"), col = c("blue"), 
          main = str.main[i]) 
  abline(v=nr_lev, col="blue")
}