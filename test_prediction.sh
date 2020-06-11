#!/usr/bin/env bash
URL=http://a9ba30d04ac2011eaba070279dd3f610-1553933759.eu-central-1.elb.amazonaws.com/
PORT=8000
echo "Port: $PORT"

# POST method predict
curl -d '{
   "CHAS":{
      "0":0
   },
   "RM":{
      "0":6.575
   },
   "TAX":{
      "0":296.0
   },
   "PTRATIO":{
      "0":15.3
   },
   "B":{
      "0":396.9
   },
   "LSTAT":{
      "0":4.98
   }
}'\
     -H "Content-Type: application/json" \
     -X POST http://$URL:$PORT/predict
