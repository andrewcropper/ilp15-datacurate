from xml.dom import minidom
doc = minidom.parse('mondial-clean.xml')
countries = doc.getElementsByTagName('country')
print len(countries)

i=1
for country in countries:
  with open('parsed/input-{0}.txt'.format(i),'w') as f:
    country.writexml(f)
  cities = country.getElementsByTagName('city')
  names = [city.getElementsByTagName('name')[0].childNodes[0].data.strip() for city in cities]
  with open('parsed/output-{0}.txt'.format(i),'w') as f:
    f.write('$'.join(names))
  i+=1