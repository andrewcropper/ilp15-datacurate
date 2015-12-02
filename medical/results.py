import math

max_k = 21
max_m = 6

def run(name,m):

  def mean(xs):
    if len(xs) == 0:
      return 0
    else:
      return sum(float(x) for x in xs) / len(xs)

  def variance(xs):
    mu = mean(xs)
    return sum(pow(float(x) - mu,2) for x in xs)

  def std_dev(xs):
    return math.sqrt(variance(xs))

  def std_err(xs):
    return std_dev(xs) / math.sqrt(len(xs))

  all_xs = []
  for k in range(1,max_k):
    k_xs = []
    fname = "results-delimiter-{0}/{1}-{2}.txt".format(name,k,m)
    with open(fname,'r') as f:
      for line in f:
        ys = line.split(",")
        if ys[0] != 'score':
        # if ys[0] != 'time':
          continue
        k_xs.append(float(ys[1]))
    all_xs.append(mean(k_xs))

  print "({0},{1}) +- (0,{2})".format(m,mean(all_xs),std_err(all_xs))

def f(name):
  for m in range(1,max_m):
    run(1,m)

f(1)