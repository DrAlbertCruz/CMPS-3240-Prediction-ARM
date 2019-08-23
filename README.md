# CMPS-3240-Prediction-ARM
A simple experiment to test the branch predictor on AWS Gravitron processors

## Background

Branch prediction is an optimization to reduce delays due to stalls. Contemporary processors often employ pipelining, which is particularly sensitive to stalls--especially ones that may cause a flush. *Branch prediction* is a hardware-level implementation on the micrprocessor that attempts to predict if a branch will be taken or not. Ussually, the scheme for branch prediction is decided at the implementation-level by the microprocessor manufacturer. For example, older AMD processors used a neural network for branch prediction. The textbook covers simple policies such as always-predict-taken, etc. These are called *static predictors*. Static predictors work OK in constrained scenarios, when the compiler or developer knows the processor will always make a prediction in a particular way, and most of the code contains loops that often take the same path. We desire a better prediction system.

The testbook also covers 2-bit saturating counters, where the processor maintains a counter to remember if the branch being considered was taken or not taken. The processor may make a mistake at first. However, the processor can converge to taken (T) or not taken (NT). This removes the requirement of the compiler or developer having to refactor their loops in a particular way (pre-test or post-test). 

Current processors often combine counters with a *branch target buffer*. The branch target buffer is a sort of cache that records a hash of the instruction address with a history of previous branch behavior (T or NT):

{ Some function of the instruction address, History of T or NT }

The first element is the index. For example, consider the following code:

```arm
0x04 cmp w0, 5
0x08 beq loopquit
...
0x3C loopquit: 
```

When first executing line 0x08, the processor would consult the branch table buffer to determine if the branch has been seen before. It would consult the index at some function of 0x04. If it has previously made a prediction, it uses some scheme (such as 2-bit saturating counter) to make a prediction. If it has not seen the instruction yet (there is no history) some arbitrary decision is made. 

## ARM Gravitron Prediction Unit

*Prediction unit* is the term for the overall system for branch prediction. The processor on the departmental server is an Amazon AWS Gravitron processor, which is a repackaged Alpine AL73400 processor that contains ARM Cortex A72 cores.<sup>3</sup> A technical schematic is found here.<sup>2</sup> 

## References

<sup>1</sup>http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.100095_0001_02_en/way1382448709518.html
<sup>2</sup>https://www.tomshardware.com/reviews/arm-cortex-a72-architecture,4424.html#p2
<sup>3</sup>https://en.wikichip.org/wiki/annapurna_labs/alpine/al73400
