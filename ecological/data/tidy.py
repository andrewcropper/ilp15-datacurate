# xs = set([])
# for i in range(1,28):
#   with open('output-{0}.txt'.format(i)) as f:
#     for line in f:
#       xs.add(line.strip())
#       # if line.strip().lower() == "juvenile lithobius variegatus leach":
#         # print i

# for x in sorted(xs):
#   print x


xs = set([])
for i in range(1,25):
  print ''
  print i
  with open('input-{0}.txt'.format(i)) as f1:
    with open('output-{0}.txt'.format(i)) as f2:
      for line in f1:
        print line
      for line in f2:
        print line



      # if line.strip().lower() == "juvenile lithobius variegatus leach":
        # print i

# for x in sorted(xs):
#   print x