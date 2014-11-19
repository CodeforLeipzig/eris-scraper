== import

```
cat $DOC | jq -c 'del(._id)' > r1.json
cat r1.json | curl -vv -XPOST -d @- 'http://localhost:9200/eris/papers'

cat output/resolution_fc277a85-4aa1-4378-8ed6-dd7eb1ee63f3.json | jq -c 'del(._id)' | curl -vv -XPOST -d @- 'http://localhost:9200/eris/papers'
```

== search

```
curl -vv -XGET 'http://localhost:9200/_search?q=betreff:Verm%C3%B6gensbilanz' | jq '.'
curl -vv -XGET 'http://localhost:9200/_all/_search' -d @query-1.json  | jq '.'
```

== save search

```
curl -vv -XPUT 'http://localhost:9200/eris/.percolator/1' -d @query-1.json
curl -vv -XGET 'localhost:9200/eris/.percolator/1' | jq '.'
```

== percolate

- note: document to be percolated needs enclosing 'doc' element

over all documents of one type in one index:
```
cat r1.json |jq '{doc : .}' |curl -vv -XGET 'localhost:9200/eris/paper/_percolate' -d @-
```

percolate an existing document:
```
curl -XGET 'http://localhost:9200/eris/papers/rsYySBBaReKGnQ36FC-78w/_percolate' | jq '.'
```


