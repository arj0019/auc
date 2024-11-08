[
  {
    "MOV": {
      "tgt": "x",
      "src": "1"
    }
  },
  [
    {
      "MOV": {
        "tgt": "y",
        "src": {
          "MUL": {
            "tgt": "x",
            "src": "2"
          }
        }
      }
    },
    {
      "MOV": {
        "tgt": "z",
        "src": {
          "ADD": {
            "tgt": "x",
            "src": {
              "DIV": {
                "tgt": "y",
                "src": "3"
              }
            }
          }
        }
      }
    }
  ]
]