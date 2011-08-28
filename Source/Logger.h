#if DEBUG
#define LOG(...) NSLog(__VA_ARGS__)
#else
#define LOG(...) do {} while (0);
#endif