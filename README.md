# RxStarscreamMultimodel
### Introduction 
When we connect through the socket, a string will receive as ‘Message’ through a streamline.
In many cases this string is a JSON.

### Challenge 
In our sample the json can be mapped to ModelA or ModelB or neither.
By using ‘RxStarScream’ I created 2 Maybe<ModelA> and Maybe<ModelB> that updates UI whether the received JSON can be mapped to observeable’s type or not.

## High level overview
![](https://github.com/behrad-kzm/RxStarscreamMultimodel/blob/master/res/Untitled%20Diagram.png)

### Test
- Try connecting to socket server by clicking ‘Connect’.
- Emit modelA -> the labels are updated to modelA immediately.
- Emit modelB -> the labels are updated to modelB immediately.

### Notice 
don’t forget to hit ‘star’ button on github 😋😉🤟🏻
