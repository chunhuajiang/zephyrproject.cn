title: 自定义数据 - Custom Data
---

线程的 *自定义数据（custom data）* 是由应用程序使用的 32 比特的线程相关的值，它可以用于任何目的。

# 概念

每个线程都有一个 32 比特的自定义数据区域。只有线程自己能访问它的自定义数据。应用程序可以利用自定义数据实现任何目的。线程自定义数据的默认值是 0。

> 在 ISR 中没有自定义数据，因为 ISR 是一个单一的共享内核的中断处理上下文。

# 实现

## 使用自定义数据

默认情况下，线程自定义数据的功能是关闭的。配置选项 `CONFIG_THREAD_CUSTOM_DATA` 用于使能自定义数据。

函数 `k_thread_custom_data_set()` 和 `k_thread_custom_data_get()` 分别用于写、读线程的自定义数据。线程只能访问它自己的自定义数据，不能访问其它线程的自定义数据。

下面的代码利用了自定义数据来记录各个线程访问某个例程的次数。

> 当然，只有一个例程能利用这种过技术，因为它独占了自定义数据。

```C
int call_tracking_routine(void)
{
    u32_t call_count;

    if (k_is_in_isr()) {
        /* ignore any call made by an ISR */
    } else {
        call_count = (u32_t)k_thread_custom_data_get();
        call_count++;
        k_thread_custom_data_set((void *)call_count);
    }

    /* do rest of routine's processing */
    ...
}
```
# 建议的用法

要使用线程自定义数据时，最好将自定义数据作为一个指向线程的某个数据结构的指针。

# 配置选项

相关的配置选项：
- `CONFIG_THREAD_CUSTOM_DATA`

# API

头文件 `kernel.h` 提供了如下的线程自定义数据 API：

- `k_thread_custom_data_set()`
- `k_thread_custom_data_get()`

</br>
