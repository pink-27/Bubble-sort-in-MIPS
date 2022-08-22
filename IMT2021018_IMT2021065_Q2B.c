#define GPIO_SWs    0x80001400
#define GPIO_LEDs   0x80001404
#define GPIO_INOUT  0x80001408

#define READ_GPIO(dir) (*(volatile unsigned *)dir)
#define WRITE_GPIO(dir, value) { (*(volatile unsigned *)dir) = (value); }

#if defined(D_NEXYS_A7)
   #include <bsp_printf.h>
   #include <bsp_mem_map.h>
   #include <bsp_version.h>
#else
   PRE_COMPILED_MSG("no platform was defined")
#endif
#include <psp_api.h>

#define N 10

void swap(int* xp, int* yp) //function to swap terms in an array.
{
    int temp = *xp;
    *xp = *yp;
    *yp = temp;
}
void bubbleSort(int arr[], int n)   //function to implement bubble sort.
{
    int i, j;
    for (i = 0; i < n - 1; i++)
 
        // Last i elements are already in place
        for (j = 0; j < n - i - 1; j++)
            if (arr[j] > arr[j + 1])
                swap(&arr[j], &arr[j + 1]);
}
int main(void)
{
   int V[N], i;

   /* Initialize Uart */
   uartInit();
    //the initial array is { 3 , 1 , 4 , 2 , 5 , 10 , 7 , 6 , 9 , 8}
   V[0]=3;V[1]=1;
   V[2]=4;V[3]=2;V[4]=5;V[5]=10;
   V[6]=7;V[7]=6;V[8]=9;V[9]=8;
   int address=GPIO_LEDs;
   for(i=0;i<N;i++){
        printfNexys("V(%d)=%d",i,V[i]);      //print the value.
        WRITE_GPIO(address,V[i]);address++;  //storing the initial array in base address 80001404
   }
   //bubble sort.
   bubbleSort(V,N);
    address=0x80001414;
    printfNexys("After bubblesort:");
    for(i=0;i<N;i++){
        printfNexys("V(%d)=%d",i,V[i]);
        WRITE_GPIO(address,V[i]);address++;
    }
    return 0;
}