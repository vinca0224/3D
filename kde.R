version

# install.packages("rgl")
# install.packages("misc3d")
# install.packages("scatterplot3d")

installed.packages("misc3d")
installed.packages("rgl")

## 라이브러리 호출
library("misc3d")
library("rgl")
library("scatterplot3d")

## 데이터 로드
data  <- read.csv("../3D/points.csv")
x <- data[,1]
y <- data[,2]
z <- data[,3]

## range()로 범위 지정시 벽면 짤려서 축마다 여유있게 범위 설정
range_x <- range(x)
range_y <- range(y)
range_z <- range(z)

limit <- list(
    xlim = range_x + c(-1,1),
    ylim = range_y + c(-1,1),
    zlim = range_z + c(-1,1)
)
## raw data 확인용
# kde_result <- kde3d(x, y, z, h = 0.01, n = 100, lims = c(limit$xlim, limit$y, limit$z))
# open3d()
# contour3d(kde_result$d, level = 0.01, kde_result$x, kde_result$y, kde_result$z, color = "red")


## 밀도 추정
kde_result <- kde3d(x, y, z,  n = 100, lims = c(limit$xlim, limit$ylim, limit$zlim))
dens <- kde_result$d

## 밀도만 따로 csv로 저장
write.csv(dens, "density.csv")

## 시각화
open3d()
plot3d(kde_result$x, kde_result$y, kde_result$z, col = "lightblue", size = 3)
contour3d(kde_result$d, level = 0.001, kde_result$x, kde_result$y, kde_result$z, color = "red")


