#define EXPORT extern "C" __attribute__((visibility("default"))) __attribute__((used))
#include <cstring>
EXPORT
int add(int a, int b) {
   return a + b;
}