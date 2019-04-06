#! /usr/local/bin/MathematicaScript -script

probland[] := Module[
  {
    min = 0,
    max = 100,
    inc = 1,
    steps = 250,
    randos,
    next,
    timeline,
    timelines
  },
  next = Function[
    {state, rando},
    If[
      state == min || state == max,
      state,
      If[rando <= state, state + inc, state - inc]
    ]
  ];
  randos = RandomInteger[{min, max}, steps];
  timeline = Function[state, FoldList[next, state, randos]];
  timelines = Map[timeline, Range[min + inc, max - inc, inc]];
  ListLinePlot[timelines]
];

main[] := Module[
  {
    argv = $ScriptCommandLine,
    runs,
    dpi = 300
  },
  runs = If[Length[argv] > 1, ToExpression[argv[[2]]], 1];
  Table[
    Export[
      "rain-" <> ToString[i] <> ".png",
      probland[],
      ImageResolution -> dpi
    ],
    {i, runs}
  ];
];

main[];
