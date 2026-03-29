terraform { 
  cloud { 
    
    organization = "VelanInc" 

    workspaces { 
      name = "aws-cost-anomaly-detection-cli" 
    } 
  } 
}