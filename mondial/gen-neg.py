import sys
import random
import subprocess
counts = []
cities = []

# fname = 'data/parsed/input-1.txt'
fname = sys.argv[1]


# print fname


import xml.etree.ElementTree as ET
tree = ET.parse(fname)
xs = []
for  elt in tree.iter():
  if type(elt.text) is str and len(elt.text.strip()) >0:
    xs.append(elt.text.strip())

# print xs
sample_size = random.randint(1, len(xs))
# print xs
ys = random.sample(xs, sample_size)
# ys.append(xs[0])
print '$'.join(ys)
# countries = doc.getElementsByTagName('country')
# print len(countries)

# i=1
# for country in countries:
#   with open('parsed/input-{0}.txt'.format(i),'w') as f:
#     country.writexml(f)
#   cities = country.getElementsByTagName('city')
#   names = [city.getElementsByTagName('name')[0].childNodes[0].data.strip() for city in cities]
#   with open('parsed/output-{0}.txt'.format(i),'w') as f:
#     f.write('$'.join(names))
#   i+=1