library(ggplot2)

generate_barplot = function(){
  
  base_val = 1.04 

  barchart_dataset = data.frame(
    'Zone' = c('Neighboorhood', 'Zurich City', 'Canton', 'Switzerland'),
    'Score' = c(.96, 1.06, 1.1, 1.02)
    
  )
  
  barchart_dataset$Diff = paste0(100*round(
    (base_val - barchart_dataset$Score) / barchart_dataset$Score,
    2), '%')
  
  p<-ggplot(data=barchart_dataset, aes(x=Zone, y=Score)) +
    geom_bar(stat="identity", fill = '#1a9988') + scale_x_discrete(limits = barchart_dataset$Zone) + 
    geom_hline(yintercept = base_val, linetype = 'dashed', size = 2, color = '#eb5600') + 
    guides(fill = FALSE) + 
    theme(text = element_text(size=20)) + 
    geom_text(aes(label = Diff),
              size = 10, 
              color = '#0f594f',
              position = position_stack(vjust = 0.5))
  
  return(p)
  
}
