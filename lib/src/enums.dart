part of metal;

/// Stages of the function call (mine)
enum ProductionProcess {
  stale,
  mining,
  mined,
  error,
}

enum MiningMethod {
  post,
  get,
  delete,
  put,
  patch,
}
