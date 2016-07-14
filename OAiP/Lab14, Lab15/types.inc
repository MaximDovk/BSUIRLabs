type
  // Перечесление всех вершин графа
  TVertex = (b1, b2, b3, b4, b5, b6, b7, b8, b9, b10);
  // Множество соседей вершины графа
  TNeighbors = set of TVertex;
  // Массив множеств соседей вершин графа
  TGraph = array [TVertex] of TNeighbors;