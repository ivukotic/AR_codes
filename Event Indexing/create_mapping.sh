curl -XPOST  'atlas-kibana.mwt2.org:9200/_template/ar-events' -d '{
    "template" : "ar-events",
    "settings" : {
        "number_of_shards" : 1,
        "number_of_replicas" : 1
    },
    "mappings" : {
        "CaloCalTopoClusters" : {
	        "_parent": { "type": "event" },
            "properties" : {
                "phi":{"type" : "float"},
                "eta":{"type" : "float"},
                "energy":{"type" : "float"}
            }
        },
        "AntiKt10LCTopoJets" : {
	        "_parent": { "type": "event" },
            "properties" : {
                "phi":{"type" : "float"},
                "eta":{"type" : "float"},                
	            "coneR":{"type" : "float"},
                "energy":{"type" : "float"}
            }
        },
        "InDetTrackParticles" : {
	        "_parent": { "type": "event" },
            "properties" : {
                "chi2":{"type" : "float"},
                "dof":{"type" : "integer"},
                "hit":{"type" : "nested", 
                    "properties": {
                        "x":    { "type": "float"  },
                        "y":    { "type": "float"  },
                        "z":    { "type": "float"   }
                    }
                }
            }
        },
        "CombinedMuonTrackParticles" : {
	        "_parent": { "type": "event" },
            "properties" : {
                "chi2":{"type" : "float"},
                "dof":{"type" : "integer"},
                "hit":{"type" : "nested", 
                    "properties": {
                        "x":    { "type": "float"  },
                        "y":    { "type": "float"  },
                        "z":    { "type": "float"   }
                    }
                }
	        }
        },
        "event" : {
            "properties" : {
                "description":{"type" : "text"},
                "runnr":{"type" : "long"} 
            }
        }
    }
}'