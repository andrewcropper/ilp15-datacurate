# import sys
# import random
# import subprocess
# counts = []
# cities = []

# ename = sys.argv[1]
# trials = int(sys.argv[2])
# instances = int(sys.argv[3])

# # for i in range(1,232):
# #   with open('parsed/output-{0}.txt'.format(i),'r') as f:
# #     xs = [x.strip() for x in f]
# #     cities.extend(xs)
# #     counts.append(len(xs))

# for i in range(1,232):
#   with open('data/parsed/output-{0}.txt'.format(i),'r') as f:
#     ys = [x.strip() for x in f]
#     xs = ys[0].split('$')
#     cities.extend(xs)
#     counts.append(len(xs))

# def neg_example():
#   n = random.choice(counts)
#   return [random.choice(cities) for k in range(0,n)]

# def write_neg_example(fname):
#   with open(fname,'w') as f:
#     f.write('$'.join(neg_example()))
#     # f.write('\n'.join(neg_example()))

# for k in range(1,trials+1):
#   for n in range(1,instances+1):

#     # neg train
#     for i in range(1,n+1):
#       j = random.randint(1,231)
#       write_neg_example('{0}/train/neg-output-{1}-{2}-{3}.txt'.format(ename,n,k,i))

#     # neg test
#     for i in range(1,11):
#       j = random.randint(1,231)
#       write_neg_example('{0}/test/neg-output-{1}-{2}-{3}.txt'.format(ename,n,k,i))