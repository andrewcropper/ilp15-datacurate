xs = set([])
for i in range(1,28):
  with open('output-{0}.txt'.format(i)) as f:
    for line in f:
      xs.add(line.strip())
      # if line.strip().lower() == "juvenile lithobius variegatus leach":
        # print i

for x in sorted(xs):
  print x