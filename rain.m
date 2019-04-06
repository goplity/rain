#! /usr/local/bin/MathematicaScript -script

rain[] := Module[
  {
    min = 0,
    max = 100,
    step = 1,
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
      If[rando <= state, state + step, state - step]
    ]
  ];
  randos = RandomInteger[{min, max}, steps];
  timeline = Function[state, FoldList[next, state, randos]];
  timelines = Map[timeline, Range[min + step, max - step, step]];
  ListLinePlot[timelines, PlotTheme -> "Detailed"]
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
      rain[],
      ImageResolution -> dpi
    ],
    {i, runs}
  ];
];

main[];
