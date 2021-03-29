car_vector <- function(jsonlink) {
  
  json <- fromJSON(jsonlink,flatten=TRUE)
  
  c(toString(data.frame(json[[1]][2])[1,]),
  toString(data.frame(json[[1]][3])[2,]),
  toString(data.frame(json[[1]][4])[3,]),
  toString(data.frame(json[[1]][5])[1,]),
  toString(data.frame(json[[1]][6])[,3]),
  toString(data.frame(json[[1]][7])[1,]),
  toString(data.frame(json[[1]][8])[2,]),
  toString(data.frame(json[[1]][9])[1,]),
  toString(data.frame(json[[1]][10])[1,]),
  toString(data.frame(json[[1]][11])[1,]),
  toString(data.frame(json[[1]][12])[1,]),
  toString(data.frame(json[[1]][13])[1,]),
  toString(data.frame(json[[1]][14])[1,]),
  toString(data.frame(json[[1]][15])[2,]),
  toString(data.frame(json[[1]][16])[2,]),
  toString(data.frame(json[[1]][17])[2,]),
  toString(data.frame(json[[1]][18])[1,2]),
  toString(data.frame(json[[1]][18])[1,3]),
  toString(data.frame(json[[1]][18])[1,5]),
  toString(data.frame(json[[1]][18])[1,4]),
  toString(data.frame(json[[1]][18])[1,9]),
  toString(data.frame(json[[1]][18])[1,10]))
  
}