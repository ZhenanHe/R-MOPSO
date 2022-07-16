# Robust Multi-Objective Optimization for Vehicle Routing Problem with Time Window (R-MOPSO)

This repository provides implementations for our [paper](https://ieeexplore.ieee.org/abstract/document/9345393) published in TCYB:

> **J. Duan, Z. He and G. G. Yen, "Robust Multiobjective Optimization for Vehicle Routing Problem With Time Windows," in *IEEE Transactions on Cybernetics*, doi: 10.1109/TCYB.2021.3049635.**

## Abstract

In this article, we focus on the vehicle routing problem (VRP) with time windows under uncertainty. To capture the uncertainty characteristics in a real-life scenario, we design a new form of disturbance on travel time and construct robust multiobjective VRP with the time window, where the perturbation range of travel time is determined by the maximum disturbance degree. Two conflicting objectives include: 1)the minimization of both the total distance and: 2)the number of vehicles. A robust multiobjective particle swarms optimization approach is developed by incorporating an advanced encoding and decoding scheme, a robustness measurement metric, as well as the local search strategy. First, through particle flying in the decision space, the problem space characteristic under deterministic environment is fully exploited to provide guidance for robust optimization. Then, a designed metric is adopted to measure the robustness of solutions and help to search for the robust optimal solutions during the particle flying process. In addition to the updating process of particle, two local search strategies, problem-based local search and route-based local search, are developed for further improving the performance of solutions. For comparison, we develop several robust optimization problems by adding disturbances on selected benchmark problems. The experimental results validate our proposed algorithm has a distinguished ability to generate enough robust solutions and ensure the optimality of these solutions.

## Benchmark and parameter

We construct RMO-VRPTW by adding the disturbance on [Solomon’s Benchmark](http://web.cba.neu.edu/~msolomon/problems.htm), which provides the coordinate, demand, service time and time window of customers, as well as the capacity of vehicles related to VRPTW. At each problem, we add disturbance on travel time of all arcs and the pre-determined maximum disturbance degree makes travel time fluctuate in a range. The maximum disturbance is defined in `code/mian.m`:

> phi=1: the maximum disturbance degree on each arc is 1

The Solomon Benchmark is provided in `../testdata`. To use these benchmark problems, the code in `../code/main.m` should be changed as follows (r10125 is used as an example):

```matlab
load('r1_type.mat');
demand=r10125(:,4);
timewindow=r10125(:,5:6);
ser=r10125(:,7);
capacity=200;
```

 By running `../code/main.m` program, the R-MOPSO can be launched. 

## Citation

If you find our work and this repository useful. Please consider giving a star and citation.

The paper is accepted by TCYB and the at the status of 'Early Access'. Bibtex is as follows:

```latex
@article{rmopso,
  title={Robust multiobjective optimization for vehicle routing problem with time windows},
  author={Duan, Jiahui and He, Zhenan and Yen, Gary G},
  journal={IEEE Transactions on Cybernetics},
  year={2021},
  publisher={IEEE}
}
```