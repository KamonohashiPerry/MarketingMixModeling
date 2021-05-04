data {
  int N;
  int K1;
  int K2;
  real max_intercept;
  matrix[N, K1] X1;
  matrix[N, K2] X2;
  vector[N] y;
}

parameters {
  vector<lower=0>[K1] beta1;
  vector[K2] beta2;
  real<lower=0, upper=max_intercept> alpha; // 定数項
  real<lower=0> noise_var;
}

model {
  // define the prior
  beta1 ~ normal(0, 1); // 係数が従う事前分布として正規分布（正の相関の変数）
  beta2 ~ normal(0, 1); // 係数が従う事前分布として正規分布（季節性の変数）
  noise_var ~ inv_gamma(0.05, 0.05 * 0.01); // 誤差項の標準偏差の事前分布として逆ガンマ分布
  
  // the likelihood
  y ~ normal(X1*beta1 + X2*beta2 + alpha, sqrt(noise_var)); // 線形のモデルとして正規分布に従う
}
