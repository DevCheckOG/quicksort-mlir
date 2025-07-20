module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi32>>, #dlti.dl_entry<i8, dense<8> : vector<2xi32>>, #dlti.dl_entry<i1, dense<8> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi32>>, #dlti.dl_entry<f16, dense<16> : vector<2xi32>>, #dlti.dl_entry<f64, dense<64> : vector<2xi32>>, #dlti.dl_entry<i32, dense<32> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi32>>, #dlti.dl_entry<i64, dense<64> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f128, dense<128> : vector<2xi32>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi32>>, #dlti.dl_entry<f80, dense<128> : vector<2xi32>>, #dlti.dl_entry<i128, dense<128> : vector<2xi32>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i32>>} {
  
  llvm.mlir.global private constant @first_format("%d  \00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private constant @second_format("\0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private constant @unsorted_array(dense<[8, 7, 2, 1, 0, 9, 6]> : tensor<7xi32>) {addr_space = 0 : i32, alignment = 4 : i64, dso_local} : !llvm.array<7 x i32>
  llvm.mlir.global private constant @unsorted_array_display("Unsorted Array\0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private constant @sorted_array_display("Sorted array: \0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  
  llvm.func @swap(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %2 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %5, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %8 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %7, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    %9 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %9, %10 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  
  llvm.func @partition(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %8 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %9 = llvm.sext %8 : i32 to i64
    %10 = llvm.getelementptr inbounds %7[%9] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %11 = llvm.load %10 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %11, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.sub %12, %0  : i32
    llvm.store %13, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %14 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.store %14, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  
    %15 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %16 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %17 = llvm.icmp "slt" %15, %16 : i32
    llvm.cond_br %17, ^bb2, ^bb6
  ^bb2:  
    %18 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %19 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %20 = llvm.sext %19 : i32 to i64
    %21 = llvm.getelementptr inbounds %18[%20] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %22 = llvm.load %21 {alignment = 4 : i64} : !llvm.ptr -> i32
    %23 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %24 = llvm.icmp "sle" %22, %23 : i32
    llvm.cond_br %24, ^bb3, ^bb4
  ^bb3: 
    %25 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %26 = llvm.add %25, %0  : i32
    llvm.store %26, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %27 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %28 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %29 = llvm.sext %28 : i32 to i64
    %30 = llvm.getelementptr inbounds %27[%29] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %31 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %32 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %33 = llvm.sext %32 : i32 to i64
    %34 = llvm.getelementptr inbounds %31[%33] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call @swap(%30, %34) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.br ^bb4
  ^bb4: 
    llvm.br ^bb5
  ^bb5: 
    %35 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    %36 = llvm.add %35, %0  : i32
    llvm.store %36, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb6:  
    %37 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %38 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %39 = llvm.add %38, %0  : i32
    %40 = llvm.sext %39 : i32 to i64
    %41 = llvm.getelementptr inbounds %37[%40] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %42 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %43 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %44 = llvm.sext %43 : i32 to i64
    %45 = llvm.getelementptr inbounds %42[%44] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.call @swap(%41, %45) : (!llvm.ptr, !llvm.ptr) -> ()
    %46 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32
    %47 = llvm.add %46, %0  : i32
    llvm.return %47 : i32
  }
  
  llvm.func @quickSort(%arg0: !llvm.ptr, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %arg2, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %6 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.icmp "slt" %5, %6 : i32
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1: 
    %8 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %11 = llvm.call @partition(%8, %9, %10) : (!llvm.ptr, i32, i32) -> i32
    llvm.store %11, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %13 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %14 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %15 = llvm.sub %14, %0  : i32
    llvm.call @quickSort(%12, %13, %15) : (!llvm.ptr, i32, i32) -> ()
    %16 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %17 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %18 = llvm.add %17, %0  : i32
    %19 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @quickSort(%16, %18, %19) : (!llvm.ptr, i32, i32) -> ()
    llvm.br ^bb2
  ^bb2: 
    llvm.return
  }

  llvm.func @printArray(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant("\0A\00") : !llvm.array<2 x i8>
    %3 = llvm.mlir.addressof @second_format : !llvm.ptr
    %4 = llvm.mlir.constant("%d  \00") : !llvm.array<5 x i8>
    %5 = llvm.mlir.addressof @first_format : !llvm.ptr
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %6 {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %arg1, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  
    %9 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    %11 = llvm.icmp "slt" %9, %10 : i32
    llvm.cond_br %11, ^bb2, ^bb4
  ^bb2:  
    %12 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %13 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %14 = llvm.sext %13 : i32 to i64
    %15 = llvm.getelementptr inbounds %12[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %16 = llvm.load %15 {alignment = 4 : i64} : !llvm.ptr -> i32
    %17 = llvm.call @printf(%5, %16) : (!llvm.ptr, i32) -> i32
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %18 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %19 = llvm.add %18, %0  : i32
    llvm.store %19, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1
  ^bb4: 
    %20 = llvm.call @printf(%3) : (!llvm.ptr) -> i32
    llvm.return
  }
  
  llvm.func @printf(!llvm.ptr, ...) -> i32
  
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(dense<[8, 7, 2, 1, 0, 9, 6]> : tensor<7xi32>) : !llvm.array<7 x i32>
    %2 = llvm.mlir.addressof @unsorted_array : !llvm.ptr
    %3 = llvm.mlir.constant(28 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(7 : i32) : i32
    %6 = llvm.mlir.constant("Unsorted Array\0A\00") : !llvm.array<16 x i8>
    %7 = llvm.mlir.addressof @unsorted_array_display : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i64) : i64
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.mlir.constant("Sorted array: \0A\00") : !llvm.array<16 x i8>
    %11 = llvm.mlir.addressof @sorted_array_display : !llvm.ptr
    %12 = llvm.alloca %0 x !llvm.array<7 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %13 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%12, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.store %5, %13 {alignment = 4 : i64} : i32, !llvm.ptr
    %14 = llvm.call @printf(%7) : (!llvm.ptr) -> i32
    %15 = llvm.getelementptr inbounds %12[%8, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i32>
    %16 = llvm.load %13 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @printArray(%15, %16) : (!llvm.ptr, i32) -> ()
    %17 = llvm.getelementptr inbounds %12[%8, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i32>
    %18 = llvm.load %13 {alignment = 4 : i64} : !llvm.ptr -> i32
    %19 = llvm.sub %18, %0  : i32
    llvm.call @quickSort(%17, %9, %19) : (!llvm.ptr, i32, i32) -> ()
    %20 = llvm.call @printf(%11) : (!llvm.ptr) -> i32
    %21 = llvm.getelementptr inbounds %12[%8, %8] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<7 x i32>
    %22 = llvm.load %13 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.call @printArray(%21, %22) : (!llvm.ptr, i32) -> ()
    llvm.return %9 : i32
  }

}
