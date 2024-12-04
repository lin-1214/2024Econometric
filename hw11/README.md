## Homework: 2024/12/04

1. Let $\{ Y_t \}_{t=1}^T$ be an IID sequence of random variables with the mean $\mu$ and the variance $\sigma^2$. Define the lag-$k$ autocorrelation coefficient:
   $$\rho(k) := \text{corr}(Y_t, Y_{t-k})$$
   and the lag-$k$ sample autocorrelation coefficient:
   $$\hat{\rho}(k) := \frac{1}{T-k} \sum_{t=k+1}^T \left( \frac{Y_t - \bar{Y}}{\hat{\sigma}} \right) \left( \frac{Y_{t-k} - \bar{Y}}{\hat{\sigma}} \right),$$
   where $\bar{Y} := \frac{1}{T} \sum_{t=1}^T Y_t$ and $\hat{\sigma}^2 := \frac{1}{T} \sum_{t=1}^T (Y_t - \bar{Y})^2$, for some fixed $k$ which is smaller than $T$. Please show that
   $$T \hat{\rho}^2(k) \overset{d}{\to} \chi^2(1),$$

2. Following #1, please show that the "Box-Pierce statistic:"
   $$Q(m) := T \sum_{k=1}^m \hat{\rho}^2(k)$$
   has the asymptotic distribution:
   $$Q(m) \overset{d}{\to} \chi^2(m),$$
   as $T \to \infty$, where $m$ is fixed and smaller than $T$.

3. Consider the following variables defined in Equity_Premium.csv:

   - $y$: Equity premium (current)
   - $x_{dfy}$: Default yield spread (lagged)
   - $x_{infl}$: Inflation (lagged)
   - $x_{svar}$: Stock variance (lagged)
   - $x_{tms}$: Term spread (lagged)
   - $x_{tbl}$: Treasury-bill rate (lagged)
   - $x_{dfr}$: Default return spread (lagged)
   - $x_{dp}$: Dividend price ratio (lagged)
   - $x_{ltr}$: Long-term return (lagged)
   - $x_{ep}$: Earnings price ratio (lagged)
   - $x_{bmr}$: Book to market (lagged)
   - $x_{ntis}$: Net equity expansion (lagged)

   Please plot the sample autocorrelation function: $\{ \hat{\rho}(k) \}_{k=1}^{24}$ and the 95% asymptotic confidence interval of $\rho(k)$, for $k = 1, 2, \ldots, 24$, in the same figure for each of the 12 time series. In addition, please test the null of IIDness for each of these time series using the Box-Pierce test statistic $Q(m)$, for $m = 12$ or $24$, at the 5% level.
