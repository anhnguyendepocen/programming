       ЃK"	   ъ^жAbrain.Event:2рс*Ж8     XZЫ		ъ^жA"Љё
h
placeholders/sampled_usersPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_pos_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_neg_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
q
 variables/truncated_normal/shapeConst*
valueB"  
   *
dtype0*
_output_shapes
:
d
variables/truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
f
!variables/truncated_normal/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2в	*
T0*
seedБџх)*
dtype0*
_output_shapes
:	


variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	


variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	

s
"variables/truncated_normal_1/shapeConst*
valueB"m  
   *
dtype0*
_output_shapes
:
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
h
#variables/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2в	*
T0*
seedБџх)*
dtype0*
_output_shapes
:	э

Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	э


variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	э


variables/user_factors
VariableV2*
	container *
dtype0*
shared_name *
shape:	
*
_output_shapes
:	

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
use_locking(*)
_class
loc:@variables/user_factors*
T0*
validate_shape(*
_output_shapes
:	


variables/user_factors/readIdentityvariables/user_factors*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	


variables/item_factors
VariableV2*
	container *
dtype0*
shared_name *
shape:	э
*
_output_shapes
:	э

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
use_locking(*)
_class
loc:@variables/item_factors*
T0*
validate_shape(*
_output_shapes
:	э


variables/item_factors/readIdentityvariables/item_factors*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	э

^
variables/zerosConst*
valueBэ*    *
dtype0*
_output_shapes	
:э

variables/item_bias
VariableV2*
	container *
dtype0*
shared_name *
shape:э*
_output_shapes	
:э
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
use_locking(*&
_class
loc:@variables/item_bias*
T0*
validate_shape(*
_output_shapes	
:э

variables/item_bias/readIdentityvariables/item_bias*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:э
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
a
loss/subSubloss/pos_itemsloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

W
loss/mulMul
loss/usersloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

\
loss/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 

loss/SumSumloss/mulloss/Sum/reduction_indices*
	keep_dims( *

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
S
loss/addAdd
loss/sub_1loss/Sum*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/NegNegloss/add*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/ExpExploss/Neg*
T0*#
_output_shapes
:џџџџџџџџџ
Q
loss/add_1/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
W

loss/add_1Addloss/add_1/xloss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
I
loss/LogLog
loss/add_1*
T0*#
_output_shapes
:џџџџџџџџџ
I

loss/Neg_1Negloss/Log*
T0*#
_output_shapes
:џџџџџџџџџ
T

loss/ConstConst*
valueB: *
dtype0*
_output_shapes
:
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
O

loss/pow/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
Y
loss/powPow
loss/users
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_1Const*
valueB"       *
dtype0*
_output_shapes
:
g

loss/Sum_2Sumloss/powloss/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_1/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_2Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_2/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_3Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_4Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_3/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_5Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
T0*
_output_shapes
: 
J

loss/add_4Add
loss/mul_1
loss/add_2*
T0*
_output_shapes
: 
J

loss/add_5Add
loss/add_4
loss/add_3*
T0*
_output_shapes
: 
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
T0*
_output_shapes
: 
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
T
gradients/ConstConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_5_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_5_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1*
T0*
_output_shapes
: 
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0*
_output_shapes
: 
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/pow_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

`
gradients/loss/pow_grad/LogLog
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

у
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1*
T0*
_output_shapes
: 
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_3_grad/LogLogloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1*
T0*
_output_shapes
: 

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_1_grad/LogLogloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/add_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
T0*
out_type0*
_output_shapes
:
^
gradients/loss/Sum_grad/SizeConst*
value	B :*
dtype0*
_output_shapes
: 
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 

gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
dtype0*
_output_shapes
: 

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
N*
T0*#
_output_shapes
:џџџџџџџџџ
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*
T0*#
_output_shapes
:џџџџџџџџџ

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
T0*
_output_shapes
:
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/pos_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/neg_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/mul_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

W
gradients/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/users_grad/ShapeConst*)
_class
loc:@variables/user_factors*
valueB"  
   *
dtype0*
_output_shapes
:
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
T0*
out_type0*
_output_shapes
: 
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/pos_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/neg_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
N*

Tidx0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Y
gradients/concat_3/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
b
GradientDescent/learning_rateConst*
valueB
 *ЭЬЬ=*
dtype0*
_output_shapes
: 
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*)
_class
loc:@variables/user_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/user_factors*
_output_shapes
:	

б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*)
_class
loc:@variables/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/item_factors*
_output_shapes
:	э

М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*&
_class
loc:@variables/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
Tindices0*
use_locking( *
T0*&
_class
loc:@variables/item_bias*
_output_shapes	
:э
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
dtype0*
_output_shapes
: 
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
N*
_output_shapes
: 
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign
j
placeholders_1/sampled_usersPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
n
 placeholders_1/sampled_pos_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
n
 placeholders_1/sampled_neg_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
s
"variables_1/truncated_normal/shapeConst*
valueB"  
   *
dtype0*
_output_shapes
:
f
!variables_1/truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
h
#variables_1/truncated_normal/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
З
,variables_1/truncated_normal/TruncatedNormalTruncatedNormal"variables_1/truncated_normal/shape*
seed2в	*
T0*
seedБџх)*
dtype0*
_output_shapes
:	

Є
 variables_1/truncated_normal/mulMul,variables_1/truncated_normal/TruncatedNormal#variables_1/truncated_normal/stddev*
T0*
_output_shapes
:	


variables_1/truncated_normalAdd variables_1/truncated_normal/mul!variables_1/truncated_normal/mean*
T0*
_output_shapes
:	

u
$variables_1/truncated_normal_1/shapeConst*
valueB"m  
   *
dtype0*
_output_shapes
:
h
#variables_1/truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
j
%variables_1/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
Л
.variables_1/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_1/truncated_normal_1/shape*
seed2в	*
T0*
seedБџх)*
dtype0*
_output_shapes
:	э

Њ
"variables_1/truncated_normal_1/mulMul.variables_1/truncated_normal_1/TruncatedNormal%variables_1/truncated_normal_1/stddev*
T0*
_output_shapes
:	э


variables_1/truncated_normal_1Add"variables_1/truncated_normal_1/mul#variables_1/truncated_normal_1/mean*
T0*
_output_shapes
:	э


variables_1/user_factors
VariableV2*
	container *
dtype0*
shared_name *
shape:	
*
_output_shapes
:	

с
variables_1/user_factors/AssignAssignvariables_1/user_factorsvariables_1/truncated_normal*
use_locking(*+
_class!
loc:@variables_1/user_factors*
T0*
validate_shape(*
_output_shapes
:	


variables_1/user_factors/readIdentityvariables_1/user_factors*+
_class!
loc:@variables_1/user_factors*
T0*
_output_shapes
:	


variables_1/item_factors
VariableV2*
	container *
dtype0*
shared_name *
shape:	э
*
_output_shapes
:	э

у
variables_1/item_factors/AssignAssignvariables_1/item_factorsvariables_1/truncated_normal_1*
use_locking(*+
_class!
loc:@variables_1/item_factors*
T0*
validate_shape(*
_output_shapes
:	э


variables_1/item_factors/readIdentityvariables_1/item_factors*+
_class!
loc:@variables_1/item_factors*
T0*
_output_shapes
:	э

`
variables_1/zerosConst*
valueBэ*    *
dtype0*
_output_shapes	
:э

variables_1/item_bias
VariableV2*
	container *
dtype0*
shared_name *
shape:э*
_output_shapes	
:э
Щ
variables_1/item_bias/AssignAssignvariables_1/item_biasvariables_1/zeros*
use_locking(*(
_class
loc:@variables_1/item_bias*
T0*
validate_shape(*
_output_shapes	
:э

variables_1/item_bias/readIdentityvariables_1/item_bias*(
_class
loc:@variables_1/item_bias*
T0*
_output_shapes	
:э
Г
loss_2/usersGathervariables_1/user_factors/readplaceholders_1/sampled_users*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Л
loss_2/pos_itemsGathervariables_1/item_factors/read placeholders_1/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Л
loss_2/neg_itemsGathervariables_1/item_factors/read placeholders_1/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

И
loss_2/pos_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
И
loss_2/neg_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
g

loss_2/subSubloss_2/pos_itemsloss_2/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

]

loss_2/mulMulloss_2/users
loss_2/sub*
T0*'
_output_shapes
:џџџџџџџџџ

^
loss_2/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 


loss_2/SumSum
loss_2/mulloss_2/Sum/reduction_indices*
	keep_dims( *

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
m
loss_2/sub_1Subloss_2/pos_item_biasloss_2/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Y

loss_2/addAddloss_2/sub_1
loss_2/Sum*
T0*#
_output_shapes
:џџџџџџџџџ
K

loss_2/NegNeg
loss_2/add*
T0*#
_output_shapes
:џџџџџџџџџ
K

loss_2/ExpExp
loss_2/Neg*
T0*#
_output_shapes
:џџџџџџџџџ
S
loss_2/add_1/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
]
loss_2/add_1Addloss_2/add_1/x
loss_2/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
M

loss_2/LogLogloss_2/add_1*
T0*#
_output_shapes
:џџџџџџџџџ
M
loss_2/Neg_1Neg
loss_2/Log*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss_2/ConstConst*
valueB: *
dtype0*
_output_shapes
:
m
loss_2/Sum_1Sumloss_2/Neg_1loss_2/Const*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss_2/pow/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
_

loss_2/powPowloss_2/usersloss_2/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

_
loss_2/Const_1Const*
valueB"       *
dtype0*
_output_shapes
:
m
loss_2/Sum_2Sum
loss_2/powloss_2/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
S
loss_2/mul_1/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
R
loss_2/mul_1Mulloss_2/mul_1/xloss_2/Sum_2*
T0*
_output_shapes
: 
S
loss_2/pow_1/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_1Powloss_2/pos_itemsloss_2/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

_
loss_2/Const_2Const*
valueB"       *
dtype0*
_output_shapes
:
o
loss_2/Sum_3Sumloss_2/pow_1loss_2/Const_2*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
S
loss_2/mul_2/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
R
loss_2/mul_2Mulloss_2/mul_2/xloss_2/Sum_3*
T0*
_output_shapes
: 
S
loss_2/pow_2/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_2Powloss_2/pos_item_biasloss_2/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
X
loss_2/Const_3Const*
valueB: *
dtype0*
_output_shapes
:
o
loss_2/Sum_4Sumloss_2/pow_2loss_2/Const_3*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
P
loss_2/add_2Addloss_2/mul_2loss_2/Sum_4*
T0*
_output_shapes
: 
S
loss_2/pow_3/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_3Powloss_2/neg_itemsloss_2/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

_
loss_2/Const_4Const*
valueB"       *
dtype0*
_output_shapes
:
o
loss_2/Sum_5Sumloss_2/pow_3loss_2/Const_4*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
S
loss_2/mul_3/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
R
loss_2/mul_3Mulloss_2/mul_3/xloss_2/Sum_5*
T0*
_output_shapes
: 
S
loss_2/pow_4/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_4Powloss_2/neg_item_biasloss_2/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
X
loss_2/Const_5Const*
valueB: *
dtype0*
_output_shapes
:
o
loss_2/Sum_6Sumloss_2/pow_4loss_2/Const_5*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
P
loss_2/add_3Addloss_2/mul_3loss_2/Sum_6*
T0*
_output_shapes
: 
P
loss_2/add_4Addloss_2/mul_1loss_2/add_2*
T0*
_output_shapes
: 
P
loss_2/add_5Addloss_2/add_4loss_2/add_3*
T0*
_output_shapes
: 
P
loss_2/sub_2Subloss_2/add_5loss_2/Sum_1*
T0*
_output_shapes
: 
T
gradients_1/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
V
gradients_1/ConstConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
_
gradients_1/FillFillgradients_1/Shapegradients_1/Const*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/sub_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/sub_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_2_grad/Shape%gradients_1/loss_2/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Џ
!gradients_1/loss_2/sub_2_grad/SumSumgradients_1/Fill3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/sub_2_grad/ReshapeReshape!gradients_1/loss_2/sub_2_grad/Sum#gradients_1/loss_2/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Г
#gradients_1/loss_2/sub_2_grad/Sum_1Sumgradients_1/Fill5gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
p
!gradients_1/loss_2/sub_2_grad/NegNeg#gradients_1/loss_2/sub_2_grad/Sum_1*
T0*
_output_shapes
:
Ћ
'gradients_1/loss_2/sub_2_grad/Reshape_1Reshape!gradients_1/loss_2/sub_2_grad/Neg%gradients_1/loss_2/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/sub_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_2_grad/Reshape(^gradients_1/loss_2/sub_2_grad/Reshape_1
ѕ
6gradients_1/loss_2/sub_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_2_grad/Reshape/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/sub_2_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_2_grad/Reshape_1/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/sub_2_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_5_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_5_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_5_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_5_grad/Shape%gradients_1/loss_2/add_5_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
е
!gradients_1/loss_2/add_5_grad/SumSum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency3gradients_1/loss_2/add_5_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_5_grad/ReshapeReshape!gradients_1/loss_2/add_5_grad/Sum#gradients_1/loss_2/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
й
#gradients_1/loss_2/add_5_grad/Sum_1Sum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency5gradients_1/loss_2/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_5_grad/Reshape_1Reshape#gradients_1/loss_2/add_5_grad/Sum_1%gradients_1/loss_2/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_5_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_5_grad/Reshape(^gradients_1/loss_2/add_5_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_5_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_5_grad/Reshape/^gradients_1/loss_2/add_5_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_5_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_5_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_5_grad/Reshape_1/^gradients_1/loss_2/add_5_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_5_grad/Reshape_1*
T0*
_output_shapes
: 
u
+gradients_1/loss_2/Sum_1_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
Ъ
%gradients_1/loss_2/Sum_1_grad/ReshapeReshape8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
o
#gradients_1/loss_2/Sum_1_grad/ShapeShapeloss_2/Neg_1*
T0*
out_type0*
_output_shapes
:
Ж
"gradients_1/loss_2/Sum_1_grad/TileTile%gradients_1/loss_2/Sum_1_grad/Reshape#gradients_1/loss_2/Sum_1_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
f
#gradients_1/loss_2/add_4_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_4_grad/Shape%gradients_1/loss_2/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
е
!gradients_1/loss_2/add_4_grad/SumSum6gradients_1/loss_2/add_5_grad/tuple/control_dependency3gradients_1/loss_2/add_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_4_grad/ReshapeReshape!gradients_1/loss_2/add_4_grad/Sum#gradients_1/loss_2/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
й
#gradients_1/loss_2/add_4_grad/Sum_1Sum6gradients_1/loss_2/add_5_grad/tuple/control_dependency5gradients_1/loss_2/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_4_grad/Reshape_1Reshape#gradients_1/loss_2/add_4_grad/Sum_1%gradients_1/loss_2/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_4_grad/Reshape(^gradients_1/loss_2/add_4_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_4_grad/Reshape/^gradients_1/loss_2/add_4_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_4_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_4_grad/Reshape_1/^gradients_1/loss_2/add_4_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_4_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_3_grad/Shape%gradients_1/loss_2/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
з
!gradients_1/loss_2/add_3_grad/SumSum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_13gradients_1/loss_2/add_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_3_grad/ReshapeReshape!gradients_1/loss_2/add_3_grad/Sum#gradients_1/loss_2/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
л
#gradients_1/loss_2/add_3_grad/Sum_1Sum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_15gradients_1/loss_2/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_3_grad/Reshape_1Reshape#gradients_1/loss_2/add_3_grad/Sum_1%gradients_1/loss_2/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_3_grad/Reshape(^gradients_1/loss_2/add_3_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_3_grad/Reshape/^gradients_1/loss_2/add_3_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_3_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_3_grad/Reshape_1/^gradients_1/loss_2/add_3_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_3_grad/Reshape_1*
T0*
_output_shapes
: 
z
!gradients_1/loss_2/Neg_1_grad/NegNeg"gradients_1/loss_2/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ
f
#gradients_1/loss_2/mul_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/mul_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_1_grad/Shape%gradients_1/loss_2/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/mul_1_grad/mulMul6gradients_1/loss_2/add_4_grad/tuple/control_dependencyloss_2/Sum_2*
T0*
_output_shapes
: 
Р
!gradients_1/loss_2/mul_1_grad/SumSum!gradients_1/loss_2/mul_1_grad/mul3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/mul_1_grad/ReshapeReshape!gradients_1/loss_2/mul_1_grad/Sum#gradients_1/loss_2/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

#gradients_1/loss_2/mul_1_grad/mul_1Mulloss_2/mul_1/x6gradients_1/loss_2/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
Ц
#gradients_1/loss_2/mul_1_grad/Sum_1Sum#gradients_1/loss_2/mul_1_grad/mul_15gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/mul_1_grad/Reshape_1Reshape#gradients_1/loss_2/mul_1_grad/Sum_1%gradients_1/loss_2/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/mul_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_1_grad/Reshape(^gradients_1/loss_2/mul_1_grad/Reshape_1
ѕ
6gradients_1/loss_2/mul_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_1_grad/Reshape/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_1_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_1_grad/Reshape_1/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/mul_1_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_2_grad/Shape%gradients_1/loss_2/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
з
!gradients_1/loss_2/add_2_grad/SumSum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_13gradients_1/loss_2/add_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_2_grad/ReshapeReshape!gradients_1/loss_2/add_2_grad/Sum#gradients_1/loss_2/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
л
#gradients_1/loss_2/add_2_grad/Sum_1Sum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_15gradients_1/loss_2/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_2_grad/Reshape_1Reshape#gradients_1/loss_2/add_2_grad/Sum_1%gradients_1/loss_2/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_2_grad/Reshape(^gradients_1/loss_2/add_2_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_2_grad/Reshape/^gradients_1/loss_2/add_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_2_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_2_grad/Reshape_1/^gradients_1/loss_2/add_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_2_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/mul_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/mul_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_3_grad/Shape%gradients_1/loss_2/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/mul_3_grad/mulMul6gradients_1/loss_2/add_3_grad/tuple/control_dependencyloss_2/Sum_5*
T0*
_output_shapes
: 
Р
!gradients_1/loss_2/mul_3_grad/SumSum!gradients_1/loss_2/mul_3_grad/mul3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/mul_3_grad/ReshapeReshape!gradients_1/loss_2/mul_3_grad/Sum#gradients_1/loss_2/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

#gradients_1/loss_2/mul_3_grad/mul_1Mulloss_2/mul_3/x6gradients_1/loss_2/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
Ц
#gradients_1/loss_2/mul_3_grad/Sum_1Sum#gradients_1/loss_2/mul_3_grad/mul_15gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/mul_3_grad/Reshape_1Reshape#gradients_1/loss_2/mul_3_grad/Sum_1%gradients_1/loss_2/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/mul_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_3_grad/Reshape(^gradients_1/loss_2/mul_3_grad/Reshape_1
ѕ
6gradients_1/loss_2/mul_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_3_grad/Reshape/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_3_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_3_grad/Reshape_1/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/mul_3_grad/Reshape_1*
T0*
_output_shapes
: 
u
+gradients_1/loss_2/Sum_6_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
Ъ
%gradients_1/loss_2/Sum_6_grad/ReshapeReshape8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
o
#gradients_1/loss_2/Sum_6_grad/ShapeShapeloss_2/pow_4*
T0*
out_type0*
_output_shapes
:
Ж
"gradients_1/loss_2/Sum_6_grad/TileTile%gradients_1/loss_2/Sum_6_grad/Reshape#gradients_1/loss_2/Sum_6_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ

&gradients_1/loss_2/Log_grad/Reciprocal
Reciprocalloss_2/add_1"^gradients_1/loss_2/Neg_1_grad/Neg*
T0*#
_output_shapes
:џџџџџџџџџ

gradients_1/loss_2/Log_grad/mulMul!gradients_1/loss_2/Neg_1_grad/Neg&gradients_1/loss_2/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
|
+gradients_1/loss_2/Sum_2_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Ю
%gradients_1/loss_2/Sum_2_grad/ReshapeReshape8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
m
#gradients_1/loss_2/Sum_2_grad/ShapeShape
loss_2/pow*
T0*
out_type0*
_output_shapes
:
К
"gradients_1/loss_2/Sum_2_grad/TileTile%gradients_1/loss_2/Sum_2_grad/Reshape#gradients_1/loss_2/Sum_2_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

f
#gradients_1/loss_2/mul_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/mul_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_2_grad/Shape%gradients_1/loss_2/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/mul_2_grad/mulMul6gradients_1/loss_2/add_2_grad/tuple/control_dependencyloss_2/Sum_3*
T0*
_output_shapes
: 
Р
!gradients_1/loss_2/mul_2_grad/SumSum!gradients_1/loss_2/mul_2_grad/mul3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/mul_2_grad/ReshapeReshape!gradients_1/loss_2/mul_2_grad/Sum#gradients_1/loss_2/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

#gradients_1/loss_2/mul_2_grad/mul_1Mulloss_2/mul_2/x6gradients_1/loss_2/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
Ц
#gradients_1/loss_2/mul_2_grad/Sum_1Sum#gradients_1/loss_2/mul_2_grad/mul_15gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/mul_2_grad/Reshape_1Reshape#gradients_1/loss_2/mul_2_grad/Sum_1%gradients_1/loss_2/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/mul_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_2_grad/Reshape(^gradients_1/loss_2/mul_2_grad/Reshape_1
ѕ
6gradients_1/loss_2/mul_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_2_grad/Reshape/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_2_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_2_grad/Reshape_1/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/mul_2_grad/Reshape_1*
T0*
_output_shapes
: 
u
+gradients_1/loss_2/Sum_4_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
Ъ
%gradients_1/loss_2/Sum_4_grad/ReshapeReshape8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
o
#gradients_1/loss_2/Sum_4_grad/ShapeShapeloss_2/pow_2*
T0*
out_type0*
_output_shapes
:
Ж
"gradients_1/loss_2/Sum_4_grad/TileTile%gradients_1/loss_2/Sum_4_grad/Reshape#gradients_1/loss_2/Sum_4_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
|
+gradients_1/loss_2/Sum_5_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Ю
%gradients_1/loss_2/Sum_5_grad/ReshapeReshape8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
o
#gradients_1/loss_2/Sum_5_grad/ShapeShapeloss_2/pow_3*
T0*
out_type0*
_output_shapes
:
К
"gradients_1/loss_2/Sum_5_grad/TileTile%gradients_1/loss_2/Sum_5_grad/Reshape#gradients_1/loss_2/Sum_5_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

w
#gradients_1/loss_2/pow_4_grad/ShapeShapeloss_2/neg_item_bias*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_4_grad/Shape%gradients_1/loss_2/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_4_grad/mulMul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
h
#gradients_1/loss_2/pow_4_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_4_grad/subSubloss_2/pow_4/y#gradients_1/loss_2/pow_4_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_4_grad/PowPowloss_2/neg_item_bias!gradients_1/loss_2/pow_4_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_4_grad/mul_1Mul!gradients_1/loss_2/pow_4_grad/mul!gradients_1/loss_2/pow_4_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Т
!gradients_1/loss_2/pow_4_grad/SumSum#gradients_1/loss_2/pow_4_grad/mul_13gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/pow_4_grad/ReshapeReshape!gradients_1/loss_2/pow_4_grad/Sum#gradients_1/loss_2/pow_4_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
l
'gradients_1/loss_2/pow_4_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_4_grad/GreaterGreaterloss_2/neg_item_bias'gradients_1/loss_2/pow_4_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
l
!gradients_1/loss_2/pow_4_grad/LogLogloss_2/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
y
(gradients_1/loss_2/pow_4_grad/zeros_like	ZerosLikeloss_2/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
а
$gradients_1/loss_2/pow_4_grad/SelectSelect%gradients_1/loss_2/pow_4_grad/Greater!gradients_1/loss_2/pow_4_grad/Log(gradients_1/loss_2/pow_4_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_4_grad/mul_2Mul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4*
T0*#
_output_shapes
:џџџџџџџџџ
Ѓ
#gradients_1/loss_2/pow_4_grad/mul_3Mul#gradients_1/loss_2/pow_4_grad/mul_2$gradients_1/loss_2/pow_4_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
Ц
#gradients_1/loss_2/pow_4_grad/Sum_1Sum#gradients_1/loss_2/pow_4_grad/mul_35gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_4_grad/Reshape_1Reshape#gradients_1/loss_2/pow_4_grad/Sum_1%gradients_1/loss_2/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_4_grad/Reshape(^gradients_1/loss_2/pow_4_grad/Reshape_1

6gradients_1/loss_2/pow_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_4_grad/Reshape/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ћ
8gradients_1/loss_2/pow_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_4_grad/Reshape_1/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_4_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
o
%gradients_1/loss_2/add_1_grad/Shape_1Shape
loss_2/Exp*
T0*
out_type0*
_output_shapes
:
е
3gradients_1/loss_2/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_1_grad/Shape%gradients_1/loss_2/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
О
!gradients_1/loss_2/add_1_grad/SumSumgradients_1/loss_2/Log_grad/mul3gradients_1/loss_2/add_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_1_grad/ReshapeReshape!gradients_1/loss_2/add_1_grad/Sum#gradients_1/loss_2/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Т
#gradients_1/loss_2/add_1_grad/Sum_1Sumgradients_1/loss_2/Log_grad/mul5gradients_1/loss_2/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
К
'gradients_1/loss_2/add_1_grad/Reshape_1Reshape#gradients_1/loss_2/add_1_grad/Sum_1%gradients_1/loss_2/add_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ

.gradients_1/loss_2/add_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_1_grad/Reshape(^gradients_1/loss_2/add_1_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_1_grad/Reshape/^gradients_1/loss_2/add_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_1_grad/Reshape*
T0*
_output_shapes
: 

8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_1_grad/Reshape_1/^gradients_1/loss_2/add_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
m
!gradients_1/loss_2/pow_grad/ShapeShapeloss_2/users*
T0*
out_type0*
_output_shapes
:
f
#gradients_1/loss_2/pow_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Я
1gradients_1/loss_2/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/pow_grad/Shape#gradients_1/loss_2/pow_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients_1/loss_2/pow_grad/mulMul"gradients_1/loss_2/Sum_2_grad/Tileloss_2/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
!gradients_1/loss_2/pow_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
x
gradients_1/loss_2/pow_grad/subSubloss_2/pow/y!gradients_1/loss_2/pow_grad/sub/y*
T0*
_output_shapes
: 

gradients_1/loss_2/pow_grad/PowPowloss_2/usersgradients_1/loss_2/pow_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


!gradients_1/loss_2/pow_grad/mul_1Mulgradients_1/loss_2/pow_grad/mulgradients_1/loss_2/pow_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

М
gradients_1/loss_2/pow_grad/SumSum!gradients_1/loss_2/pow_grad/mul_11gradients_1/loss_2/pow_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
В
#gradients_1/loss_2/pow_grad/ReshapeReshapegradients_1/loss_2/pow_grad/Sum!gradients_1/loss_2/pow_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

j
%gradients_1/loss_2/pow_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

#gradients_1/loss_2/pow_grad/GreaterGreaterloss_2/users%gradients_1/loss_2/pow_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients_1/loss_2/pow_grad/LogLogloss_2/users*
T0*'
_output_shapes
:џџџџџџџџџ

s
&gradients_1/loss_2/pow_grad/zeros_like	ZerosLikeloss_2/users*
T0*'
_output_shapes
:џџџџџџџџџ

Ь
"gradients_1/loss_2/pow_grad/SelectSelect#gradients_1/loss_2/pow_grad/Greatergradients_1/loss_2/pow_grad/Log&gradients_1/loss_2/pow_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


!gradients_1/loss_2/pow_grad/mul_2Mul"gradients_1/loss_2/Sum_2_grad/Tile
loss_2/pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ё
!gradients_1/loss_2/pow_grad/mul_3Mul!gradients_1/loss_2/pow_grad/mul_2"gradients_1/loss_2/pow_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Р
!gradients_1/loss_2/pow_grad/Sum_1Sum!gradients_1/loss_2/pow_grad/mul_33gradients_1/loss_2/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/pow_grad/Reshape_1Reshape!gradients_1/loss_2/pow_grad/Sum_1#gradients_1/loss_2/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

,gradients_1/loss_2/pow_grad/tuple/group_depsNoOp$^gradients_1/loss_2/pow_grad/Reshape&^gradients_1/loss_2/pow_grad/Reshape_1
ў
4gradients_1/loss_2/pow_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/pow_grad/Reshape-^gradients_1/loss_2/pow_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ѓ
6gradients_1/loss_2/pow_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/pow_grad/Reshape_1-^gradients_1/loss_2/pow_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_grad/Reshape_1*
T0*
_output_shapes
: 
|
+gradients_1/loss_2/Sum_3_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Ю
%gradients_1/loss_2/Sum_3_grad/ReshapeReshape8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
o
#gradients_1/loss_2/Sum_3_grad/ShapeShapeloss_2/pow_1*
T0*
out_type0*
_output_shapes
:
К
"gradients_1/loss_2/Sum_3_grad/TileTile%gradients_1/loss_2/Sum_3_grad/Reshape#gradients_1/loss_2/Sum_3_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

w
#gradients_1/loss_2/pow_2_grad/ShapeShapeloss_2/pos_item_bias*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_2_grad/Shape%gradients_1/loss_2/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_2_grad/mulMul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
h
#gradients_1/loss_2/pow_2_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_2_grad/subSubloss_2/pow_2/y#gradients_1/loss_2/pow_2_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_2_grad/PowPowloss_2/pos_item_bias!gradients_1/loss_2/pow_2_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_2_grad/mul_1Mul!gradients_1/loss_2/pow_2_grad/mul!gradients_1/loss_2/pow_2_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Т
!gradients_1/loss_2/pow_2_grad/SumSum#gradients_1/loss_2/pow_2_grad/mul_13gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/pow_2_grad/ReshapeReshape!gradients_1/loss_2/pow_2_grad/Sum#gradients_1/loss_2/pow_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
l
'gradients_1/loss_2/pow_2_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_2_grad/GreaterGreaterloss_2/pos_item_bias'gradients_1/loss_2/pow_2_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
l
!gradients_1/loss_2/pow_2_grad/LogLogloss_2/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
y
(gradients_1/loss_2/pow_2_grad/zeros_like	ZerosLikeloss_2/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
а
$gradients_1/loss_2/pow_2_grad/SelectSelect%gradients_1/loss_2/pow_2_grad/Greater!gradients_1/loss_2/pow_2_grad/Log(gradients_1/loss_2/pow_2_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_2_grad/mul_2Mul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2*
T0*#
_output_shapes
:џџџџџџџџџ
Ѓ
#gradients_1/loss_2/pow_2_grad/mul_3Mul#gradients_1/loss_2/pow_2_grad/mul_2$gradients_1/loss_2/pow_2_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
Ц
#gradients_1/loss_2/pow_2_grad/Sum_1Sum#gradients_1/loss_2/pow_2_grad/mul_35gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_2_grad/Reshape_1Reshape#gradients_1/loss_2/pow_2_grad/Sum_1%gradients_1/loss_2/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_2_grad/Reshape(^gradients_1/loss_2/pow_2_grad/Reshape_1

6gradients_1/loss_2/pow_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_2_grad/Reshape/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ћ
8gradients_1/loss_2/pow_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_2_grad/Reshape_1/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_2_grad/Reshape_1*
T0*
_output_shapes
: 
s
#gradients_1/loss_2/pow_3_grad/ShapeShapeloss_2/neg_items*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_3_grad/Shape%gradients_1/loss_2/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_3_grad/mulMul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

h
#gradients_1/loss_2/pow_3_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_3_grad/subSubloss_2/pow_3/y#gradients_1/loss_2/pow_3_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_3_grad/PowPowloss_2/neg_items!gradients_1/loss_2/pow_3_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ђ
#gradients_1/loss_2/pow_3_grad/mul_1Mul!gradients_1/loss_2/pow_3_grad/mul!gradients_1/loss_2/pow_3_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Т
!gradients_1/loss_2/pow_3_grad/SumSum#gradients_1/loss_2/pow_3_grad/mul_13gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
И
%gradients_1/loss_2/pow_3_grad/ReshapeReshape!gradients_1/loss_2/pow_3_grad/Sum#gradients_1/loss_2/pow_3_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

l
'gradients_1/loss_2/pow_3_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_3_grad/GreaterGreaterloss_2/neg_items'gradients_1/loss_2/pow_3_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

l
!gradients_1/loss_2/pow_3_grad/LogLogloss_2/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

y
(gradients_1/loss_2/pow_3_grad/zeros_like	ZerosLikeloss_2/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

д
$gradients_1/loss_2/pow_3_grad/SelectSelect%gradients_1/loss_2/pow_3_grad/Greater!gradients_1/loss_2/pow_3_grad/Log(gradients_1/loss_2/pow_3_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients_1/loss_2/pow_3_grad/mul_2Mul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3*
T0*'
_output_shapes
:џџџџџџџџџ

Ї
#gradients_1/loss_2/pow_3_grad/mul_3Mul#gradients_1/loss_2/pow_3_grad/mul_2$gradients_1/loss_2/pow_3_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Ц
#gradients_1/loss_2/pow_3_grad/Sum_1Sum#gradients_1/loss_2/pow_3_grad/mul_35gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_3_grad/Reshape_1Reshape#gradients_1/loss_2/pow_3_grad/Sum_1%gradients_1/loss_2/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_3_grad/Reshape(^gradients_1/loss_2/pow_3_grad/Reshape_1

6gradients_1/loss_2/pow_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_3_grad/Reshape/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ћ
8gradients_1/loss_2/pow_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_3_grad/Reshape_1/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_3_grad/Reshape_1*
T0*
_output_shapes
: 

gradients_1/loss_2/Exp_grad/mulMul8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1
loss_2/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
s
#gradients_1/loss_2/pow_1_grad/ShapeShapeloss_2/pos_items*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_1_grad/Shape%gradients_1/loss_2/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_1_grad/mulMul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

h
#gradients_1/loss_2/pow_1_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_1_grad/subSubloss_2/pow_1/y#gradients_1/loss_2/pow_1_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_1_grad/PowPowloss_2/pos_items!gradients_1/loss_2/pow_1_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ђ
#gradients_1/loss_2/pow_1_grad/mul_1Mul!gradients_1/loss_2/pow_1_grad/mul!gradients_1/loss_2/pow_1_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Т
!gradients_1/loss_2/pow_1_grad/SumSum#gradients_1/loss_2/pow_1_grad/mul_13gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
И
%gradients_1/loss_2/pow_1_grad/ReshapeReshape!gradients_1/loss_2/pow_1_grad/Sum#gradients_1/loss_2/pow_1_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

l
'gradients_1/loss_2/pow_1_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_1_grad/GreaterGreaterloss_2/pos_items'gradients_1/loss_2/pow_1_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

l
!gradients_1/loss_2/pow_1_grad/LogLogloss_2/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

y
(gradients_1/loss_2/pow_1_grad/zeros_like	ZerosLikeloss_2/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

д
$gradients_1/loss_2/pow_1_grad/SelectSelect%gradients_1/loss_2/pow_1_grad/Greater!gradients_1/loss_2/pow_1_grad/Log(gradients_1/loss_2/pow_1_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients_1/loss_2/pow_1_grad/mul_2Mul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1*
T0*'
_output_shapes
:џџџџџџџџџ

Ї
#gradients_1/loss_2/pow_1_grad/mul_3Mul#gradients_1/loss_2/pow_1_grad/mul_2$gradients_1/loss_2/pow_1_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Ц
#gradients_1/loss_2/pow_1_grad/Sum_1Sum#gradients_1/loss_2/pow_1_grad/mul_35gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_1_grad/Reshape_1Reshape#gradients_1/loss_2/pow_1_grad/Sum_1%gradients_1/loss_2/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_1_grad/Reshape(^gradients_1/loss_2/pow_1_grad/Reshape_1

6gradients_1/loss_2/pow_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_1_grad/Reshape/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ћ
8gradients_1/loss_2/pow_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_1_grad/Reshape_1/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_1_grad/Reshape_1*
T0*
_output_shapes
: 
u
gradients_1/loss_2/Neg_grad/NegNeggradients_1/loss_2/Exp_grad/mul*
T0*#
_output_shapes
:џџџџџџџџџ
m
!gradients_1/loss_2/add_grad/ShapeShapeloss_2/sub_1*
T0*
out_type0*
_output_shapes
:
m
#gradients_1/loss_2/add_grad/Shape_1Shape
loss_2/Sum*
T0*
out_type0*
_output_shapes
:
Я
1gradients_1/loss_2/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/add_grad/Shape#gradients_1/loss_2/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
К
gradients_1/loss_2/add_grad/SumSumgradients_1/loss_2/Neg_grad/Neg1gradients_1/loss_2/add_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ў
#gradients_1/loss_2/add_grad/ReshapeReshapegradients_1/loss_2/add_grad/Sum!gradients_1/loss_2/add_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
О
!gradients_1/loss_2/add_grad/Sum_1Sumgradients_1/loss_2/Neg_grad/Neg3gradients_1/loss_2/add_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/add_grad/Reshape_1Reshape!gradients_1/loss_2/add_grad/Sum_1#gradients_1/loss_2/add_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ

,gradients_1/loss_2/add_grad/tuple/group_depsNoOp$^gradients_1/loss_2/add_grad/Reshape&^gradients_1/loss_2/add_grad/Reshape_1
њ
4gradients_1/loss_2/add_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/add_grad/Reshape-^gradients_1/loss_2/add_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/add_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

6gradients_1/loss_2/add_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/add_grad/Reshape_1-^gradients_1/loss_2/add_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
w
#gradients_1/loss_2/sub_1_grad/ShapeShapeloss_2/pos_item_bias*
T0*
out_type0*
_output_shapes
:
y
%gradients_1/loss_2/sub_1_grad/Shape_1Shapeloss_2/neg_item_bias*
T0*
out_type0*
_output_shapes
:
е
3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_1_grad/Shape%gradients_1/loss_2/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
г
!gradients_1/loss_2/sub_1_grad/SumSum4gradients_1/loss_2/add_grad/tuple/control_dependency3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/sub_1_grad/ReshapeReshape!gradients_1/loss_2/sub_1_grad/Sum#gradients_1/loss_2/sub_1_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
з
#gradients_1/loss_2/sub_1_grad/Sum_1Sum4gradients_1/loss_2/add_grad/tuple/control_dependency5gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
p
!gradients_1/loss_2/sub_1_grad/NegNeg#gradients_1/loss_2/sub_1_grad/Sum_1*
T0*
_output_shapes
:
И
'gradients_1/loss_2/sub_1_grad/Reshape_1Reshape!gradients_1/loss_2/sub_1_grad/Neg%gradients_1/loss_2/sub_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ

.gradients_1/loss_2/sub_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_1_grad/Reshape(^gradients_1/loss_2/sub_1_grad/Reshape_1

6gradients_1/loss_2/sub_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_1_grad/Reshape/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/sub_1_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_1_grad/Reshape_1/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/sub_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
k
!gradients_1/loss_2/Sum_grad/ShapeShape
loss_2/mul*
T0*
out_type0*
_output_shapes
:
b
 gradients_1/loss_2/Sum_grad/SizeConst*
value	B :*
dtype0*
_output_shapes
: 

gradients_1/loss_2/Sum_grad/addAddloss_2/Sum/reduction_indices gradients_1/loss_2/Sum_grad/Size*
T0*
_output_shapes
: 

gradients_1/loss_2/Sum_grad/modFloorModgradients_1/loss_2/Sum_grad/add gradients_1/loss_2/Sum_grad/Size*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/Sum_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
i
'gradients_1/loss_2/Sum_grad/range/startConst*
value	B : *
dtype0*
_output_shapes
: 
i
'gradients_1/loss_2/Sum_grad/range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
Ц
!gradients_1/loss_2/Sum_grad/rangeRange'gradients_1/loss_2/Sum_grad/range/start gradients_1/loss_2/Sum_grad/Size'gradients_1/loss_2/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
h
&gradients_1/loss_2/Sum_grad/Fill/valueConst*
value	B :*
dtype0*
_output_shapes
: 

 gradients_1/loss_2/Sum_grad/FillFill#gradients_1/loss_2/Sum_grad/Shape_1&gradients_1/loss_2/Sum_grad/Fill/value*
T0*
_output_shapes
: 
њ
)gradients_1/loss_2/Sum_grad/DynamicStitchDynamicStitch!gradients_1/loss_2/Sum_grad/rangegradients_1/loss_2/Sum_grad/mod!gradients_1/loss_2/Sum_grad/Shape gradients_1/loss_2/Sum_grad/Fill*
N*
T0*#
_output_shapes
:џџџџџџџџџ
g
%gradients_1/loss_2/Sum_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
Ў
#gradients_1/loss_2/Sum_grad/MaximumMaximum)gradients_1/loss_2/Sum_grad/DynamicStitch%gradients_1/loss_2/Sum_grad/Maximum/y*
T0*#
_output_shapes
:џџџџџџџџџ

$gradients_1/loss_2/Sum_grad/floordivFloorDiv!gradients_1/loss_2/Sum_grad/Shape#gradients_1/loss_2/Sum_grad/Maximum*
T0*
_output_shapes
:
Т
#gradients_1/loss_2/Sum_grad/ReshapeReshape6gradients_1/loss_2/add_grad/tuple/control_dependency_1)gradients_1/loss_2/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
З
 gradients_1/loss_2/Sum_grad/TileTile#gradients_1/loss_2/Sum_grad/Reshape$gradients_1/loss_2/Sum_grad/floordiv*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

љ
gradients_1/AddNAddN6gradients_1/loss_2/pow_2_grad/tuple/control_dependency6gradients_1/loss_2/sub_1_grad/tuple/control_dependency*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
 
+gradients_1/loss_2/pos_item_bias_grad/ShapeConst*(
_class
loc:@variables_1/item_bias*
valueB:э*
dtype0*
_output_shapes
:

*gradients_1/loss_2/pos_item_bias_grad/SizeSize placeholders_1/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
v
4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
б
0gradients_1/loss_2/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/pos_item_bias_grad/Size4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Й
3gradients_1/loss_2/pos_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/pos_item_bias_grad/Shape9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
s
1gradients_1/loss_2/pos_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 

,gradients_1/loss_2/pos_item_bias_grad/concatConcatV20gradients_1/loss_2/pos_item_bias_grad/ExpandDims3gradients_1/loss_2/pos_item_bias_grad/strided_slice1gradients_1/loss_2/pos_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Д
-gradients_1/loss_2/pos_item_bias_grad/ReshapeReshapegradients_1/AddN,gradients_1/loss_2/pos_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ъ
/gradients_1/loss_2/pos_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_pos_items0gradients_1/loss_2/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
§
gradients_1/AddN_1AddN6gradients_1/loss_2/pow_4_grad/tuple/control_dependency8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
 
+gradients_1/loss_2/neg_item_bias_grad/ShapeConst*(
_class
loc:@variables_1/item_bias*
valueB:э*
dtype0*
_output_shapes
:

*gradients_1/loss_2/neg_item_bias_grad/SizeSize placeholders_1/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
v
4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
б
0gradients_1/loss_2/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/neg_item_bias_grad/Size4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Й
3gradients_1/loss_2/neg_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/neg_item_bias_grad/Shape9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
s
1gradients_1/loss_2/neg_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 

,gradients_1/loss_2/neg_item_bias_grad/concatConcatV20gradients_1/loss_2/neg_item_bias_grad/ExpandDims3gradients_1/loss_2/neg_item_bias_grad/strided_slice1gradients_1/loss_2/neg_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Ж
-gradients_1/loss_2/neg_item_bias_grad/ReshapeReshapegradients_1/AddN_1,gradients_1/loss_2/neg_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ъ
/gradients_1/loss_2/neg_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_neg_items0gradients_1/loss_2/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
m
!gradients_1/loss_2/mul_grad/ShapeShapeloss_2/users*
T0*
out_type0*
_output_shapes
:
m
#gradients_1/loss_2/mul_grad/Shape_1Shape
loss_2/sub*
T0*
out_type0*
_output_shapes
:
Я
1gradients_1/loss_2/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/mul_grad/Shape#gradients_1/loss_2/mul_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients_1/loss_2/mul_grad/mulMul gradients_1/loss_2/Sum_grad/Tile
loss_2/sub*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients_1/loss_2/mul_grad/SumSumgradients_1/loss_2/mul_grad/mul1gradients_1/loss_2/mul_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
В
#gradients_1/loss_2/mul_grad/ReshapeReshapegradients_1/loss_2/mul_grad/Sum!gradients_1/loss_2/mul_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


!gradients_1/loss_2/mul_grad/mul_1Mulloss_2/users gradients_1/loss_2/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Р
!gradients_1/loss_2/mul_grad/Sum_1Sum!gradients_1/loss_2/mul_grad/mul_13gradients_1/loss_2/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
И
%gradients_1/loss_2/mul_grad/Reshape_1Reshape!gradients_1/loss_2/mul_grad/Sum_1#gradients_1/loss_2/mul_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


,gradients_1/loss_2/mul_grad/tuple/group_depsNoOp$^gradients_1/loss_2/mul_grad/Reshape&^gradients_1/loss_2/mul_grad/Reshape_1
ў
4gradients_1/loss_2/mul_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/mul_grad/Reshape-^gradients_1/loss_2/mul_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/mul_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


6gradients_1/loss_2/mul_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/mul_grad/Reshape_1-^gradients_1/loss_2/mul_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

Y
gradients_1/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
и
gradients_1/concatConcatV2-gradients_1/loss_2/pos_item_bias_grad/Reshape-gradients_1/loss_2/neg_item_bias_grad/Reshapegradients_1/concat/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
[
gradients_1/concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
р
gradients_1/concat_1ConcatV2/gradients_1/loss_2/pos_item_bias_grad/Reshape_1/gradients_1/loss_2/neg_item_bias_grad/Reshape_1gradients_1/concat_1/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
љ
gradients_1/AddN_2AddN4gradients_1/loss_2/pow_grad/tuple/control_dependency4gradients_1/loss_2/mul_grad/tuple/control_dependency*
N*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

Ё
#gradients_1/loss_2/users_grad/ShapeConst*+
_class!
loc:@variables_1/user_factors*
valueB"  
   *
dtype0*
_output_shapes
:
y
"gradients_1/loss_2/users_grad/SizeSizeplaceholders_1/sampled_users*
T0*
out_type0*
_output_shapes
: 
n
,gradients_1/loss_2/users_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients_1/loss_2/users_grad/ExpandDims
ExpandDims"gradients_1/loss_2/users_grad/Size,gradients_1/loss_2/users_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
{
1gradients_1/loss_2/users_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients_1/loss_2/users_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients_1/loss_2/users_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients_1/loss_2/users_grad/strided_sliceStridedSlice#gradients_1/loss_2/users_grad/Shape1gradients_1/loss_2/users_grad/strided_slice/stack3gradients_1/loss_2/users_grad/strided_slice/stack_13gradients_1/loss_2/users_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients_1/loss_2/users_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients_1/loss_2/users_grad/concatConcatV2(gradients_1/loss_2/users_grad/ExpandDims+gradients_1/loss_2/users_grad/strided_slice)gradients_1/loss_2/users_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Г
%gradients_1/loss_2/users_grad/ReshapeReshapegradients_1/AddN_2$gradients_1/loss_2/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ж
'gradients_1/loss_2/users_grad/Reshape_1Reshapeplaceholders_1/sampled_users(gradients_1/loss_2/users_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
q
!gradients_1/loss_2/sub_grad/ShapeShapeloss_2/pos_items*
T0*
out_type0*
_output_shapes
:
s
#gradients_1/loss_2/sub_grad/Shape_1Shapeloss_2/neg_items*
T0*
out_type0*
_output_shapes
:
Я
1gradients_1/loss_2/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/sub_grad/Shape#gradients_1/loss_2/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
б
gradients_1/loss_2/sub_grad/SumSum6gradients_1/loss_2/mul_grad/tuple/control_dependency_11gradients_1/loss_2/sub_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
В
#gradients_1/loss_2/sub_grad/ReshapeReshapegradients_1/loss_2/sub_grad/Sum!gradients_1/loss_2/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

е
!gradients_1/loss_2/sub_grad/Sum_1Sum6gradients_1/loss_2/mul_grad/tuple/control_dependency_13gradients_1/loss_2/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
l
gradients_1/loss_2/sub_grad/NegNeg!gradients_1/loss_2/sub_grad/Sum_1*
T0*
_output_shapes
:
Ж
%gradients_1/loss_2/sub_grad/Reshape_1Reshapegradients_1/loss_2/sub_grad/Neg#gradients_1/loss_2/sub_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


,gradients_1/loss_2/sub_grad/tuple/group_depsNoOp$^gradients_1/loss_2/sub_grad/Reshape&^gradients_1/loss_2/sub_grad/Reshape_1
ў
4gradients_1/loss_2/sub_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/sub_grad/Reshape-^gradients_1/loss_2/sub_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/sub_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


6gradients_1/loss_2/sub_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/sub_grad/Reshape_1-^gradients_1/loss_2/sub_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/sub_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

§
gradients_1/AddN_3AddN6gradients_1/loss_2/pow_1_grad/tuple/control_dependency4gradients_1/loss_2/sub_grad/tuple/control_dependency*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

Ѕ
'gradients_1/loss_2/pos_items_grad/ShapeConst*+
_class!
loc:@variables_1/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:

&gradients_1/loss_2/pos_items_grad/SizeSize placeholders_1/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients_1/loss_2/pos_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients_1/loss_2/pos_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/pos_items_grad/Size0gradients_1/loss_2/pos_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients_1/loss_2/pos_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients_1/loss_2/pos_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients_1/loss_2/pos_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ї
/gradients_1/loss_2/pos_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/pos_items_grad/Shape5gradients_1/loss_2/pos_items_grad/strided_slice/stack7gradients_1/loss_2/pos_items_grad/strided_slice/stack_17gradients_1/loss_2/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
o
-gradients_1/loss_2/pos_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients_1/loss_2/pos_items_grad/concatConcatV2,gradients_1/loss_2/pos_items_grad/ExpandDims/gradients_1/loss_2/pos_items_grad/strided_slice-gradients_1/loss_2/pos_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Л
)gradients_1/loss_2/pos_items_grad/ReshapeReshapegradients_1/AddN_3(gradients_1/loss_2/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Т
+gradients_1/loss_2/pos_items_grad/Reshape_1Reshape placeholders_1/sampled_pos_items,gradients_1/loss_2/pos_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
џ
gradients_1/AddN_4AddN6gradients_1/loss_2/pow_3_grad/tuple/control_dependency6gradients_1/loss_2/sub_grad/tuple/control_dependency_1*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

Ѕ
'gradients_1/loss_2/neg_items_grad/ShapeConst*+
_class!
loc:@variables_1/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:

&gradients_1/loss_2/neg_items_grad/SizeSize placeholders_1/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients_1/loss_2/neg_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients_1/loss_2/neg_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/neg_items_grad/Size0gradients_1/loss_2/neg_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients_1/loss_2/neg_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients_1/loss_2/neg_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients_1/loss_2/neg_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ї
/gradients_1/loss_2/neg_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/neg_items_grad/Shape5gradients_1/loss_2/neg_items_grad/strided_slice/stack7gradients_1/loss_2/neg_items_grad/strided_slice/stack_17gradients_1/loss_2/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
o
-gradients_1/loss_2/neg_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients_1/loss_2/neg_items_grad/concatConcatV2,gradients_1/loss_2/neg_items_grad/ExpandDims/gradients_1/loss_2/neg_items_grad/strided_slice-gradients_1/loss_2/neg_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Л
)gradients_1/loss_2/neg_items_grad/ReshapeReshapegradients_1/AddN_4(gradients_1/loss_2/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Т
+gradients_1/loss_2/neg_items_grad/Reshape_1Reshape placeholders_1/sampled_neg_items,gradients_1/loss_2/neg_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
[
gradients_1/concat_2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
с
gradients_1/concat_2ConcatV2)gradients_1/loss_2/pos_items_grad/Reshape)gradients_1/loss_2/neg_items_grad/Reshapegradients_1/concat_2/axis*
N*

Tidx0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
[
gradients_1/concat_3/axisConst*
value	B : *
dtype0*
_output_shapes
: 
и
gradients_1/concat_3ConcatV2+gradients_1/loss_2/pos_items_grad/Reshape_1+gradients_1/loss_2/neg_items_grad/Reshape_1gradients_1/concat_3/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
d
GradientDescent_1/learning_rateConst*
valueB
 *ЭЬЬ=*
dtype0*
_output_shapes
: 
ь
5GradientDescent_1/update_variables_1/user_factors/mulMul%gradients_1/loss_2/users_grad/ReshapeGradientDescent_1/learning_rate*+
_class!
loc:@variables_1/user_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
О
<GradientDescent_1/update_variables_1/user_factors/ScatterSub
ScatterSubvariables_1/user_factors'gradients_1/loss_2/users_grad/Reshape_15GradientDescent_1/update_variables_1/user_factors/mul*
Tindices0*
use_locking( *
T0*+
_class!
loc:@variables_1/user_factors*
_output_shapes
:	

л
5GradientDescent_1/update_variables_1/item_factors/mulMulgradients_1/concat_2GradientDescent_1/learning_rate*+
_class!
loc:@variables_1/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ћ
<GradientDescent_1/update_variables_1/item_factors/ScatterSub
ScatterSubvariables_1/item_factorsgradients_1/concat_35GradientDescent_1/update_variables_1/item_factors/mul*
Tindices0*
use_locking( *
T0*+
_class!
loc:@variables_1/item_factors*
_output_shapes
:	э

Ц
2GradientDescent_1/update_variables_1/item_bias/mulMulgradients_1/concatGradientDescent_1/learning_rate*(
_class
loc:@variables_1/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

9GradientDescent_1/update_variables_1/item_bias/ScatterSub
ScatterSubvariables_1/item_biasgradients_1/concat_12GradientDescent_1/update_variables_1/item_bias/mul*
Tindices0*
use_locking( *
T0*(
_class
loc:@variables_1/item_bias*
_output_shapes	
:э
г
GradientDescent_1NoOp=^GradientDescent_1/update_variables_1/user_factors/ScatterSub=^GradientDescent_1/update_variables_1/item_factors/ScatterSub:^GradientDescent_1/update_variables_1/item_bias/ScatterSub
R
loss_3/tagsConst*
valueB Bloss_3*
dtype0*
_output_shapes
: 
S
loss_3ScalarSummaryloss_3/tagsloss_2/sub_2*
T0*
_output_shapes
: 
U
Merge_1/MergeSummaryMergeSummaryloss_1loss_3*
N*
_output_shapes
: 
Ю
init_1NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign"Ц5ЧI     ЃЉxм	9а%ъ^жAJК	
ЧЅ
9
Add
x"T
y"T
z"T"
Ttype:
2	
S
AddN
inputs"T*N
sum"T"
Nint(0"
Ttype:
2	
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
S
DynamicStitch
indices*N
data"T*N
merged"T"
Nint(0"	
Ttype
+
Exp
x"T
y"T"
Ttype:	
2
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
4
Fill
dims

value"T
output"T"	
Ttype
>
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
7
FloorMod
x"T
y"T
z"T"
Ttype:
2	

Gather
params"Tparams
indices"Tindices
output"Tparams"
validate_indicesbool("
Tparamstype"
Tindicestype:
2	
:
Greater
x"T
y"T
z
"
Ttype:
2		
.
Identity

input"T
output"T"	
Ttype
+
Log
x"T
y"T"
Ttype:	
2
:
Maximum
x"T
y"T
z"T"
Ttype:	
2	
8
MergeSummary
inputs*N
summary"
Nint(0
<
Mul
x"T
y"T
z"T"
Ttype:
2	
-
Neg
x"T
y"T"
Ttype:
	2	

NoOp
A
Placeholder
output"dtype"
dtypetype"
shapeshape: 
5
Pow
x"T
y"T
z"T"
Ttype:
	2	
`
Range
start"Tidx
limit"Tidx
delta"Tidx
output"Tidx"
Tidxtype0:
2	
4

Reciprocal
x"T
y"T"
Ttype:
	2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
M
ScalarSummary
tags
values"T
summary"
Ttype:
2		
Ђ

ScatterSub
ref"T
indices"Tindices
updates"T

output_ref"T"
Ttype:
2	"
Tindicestype:
2	"
use_lockingbool( 
?
Select
	condition

t"T
e"T
output"T"	
Ttype
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
O
Size

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
і
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
5
Sub
x"T
y"T
z"T"
Ttype:
	2	

Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	

TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring 
&
	ZerosLike
x"T
y"T"	
Ttype*1.1.02v1.1.0-rc0-61-g1ec6ed5Љё
h
placeholders/sampled_usersPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_pos_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_neg_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
q
 variables/truncated_normal/shapeConst*
valueB"  
   *
dtype0*
_output_shapes
:
d
variables/truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
f
!variables/truncated_normal/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
dtype0*
T0*
seedБџх)*
seed2в	*
_output_shapes
:	


variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	


variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	

s
"variables/truncated_normal_1/shapeConst*
valueB"m  
   *
dtype0*
_output_shapes
:
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
h
#variables/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
dtype0*
T0*
seedБџх)*
seed2в	*
_output_shapes
:	э

Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	э


variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	э


variables/user_factors
VariableV2*
	container *
shared_name *
dtype0*
shape:	
*
_output_shapes
:	

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
use_locking(*)
_class
loc:@variables/user_factors*
T0*
validate_shape(*
_output_shapes
:	


variables/user_factors/readIdentityvariables/user_factors*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	


variables/item_factors
VariableV2*
	container *
shared_name *
dtype0*
shape:	э
*
_output_shapes
:	э

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
use_locking(*)
_class
loc:@variables/item_factors*
T0*
validate_shape(*
_output_shapes
:	э


variables/item_factors/readIdentityvariables/item_factors*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	э

^
variables/zerosConst*
valueBэ*    *
dtype0*
_output_shapes	
:э

variables/item_bias
VariableV2*
	container *
shared_name *
dtype0*
shape:э*
_output_shapes	
:э
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
use_locking(*&
_class
loc:@variables/item_bias*
T0*
validate_shape(*
_output_shapes	
:э

variables/item_bias/readIdentityvariables/item_bias*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:э
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
a
loss/subSubloss/pos_itemsloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

W
loss/mulMul
loss/usersloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

\
loss/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 

loss/SumSumloss/mulloss/Sum/reduction_indices*
	keep_dims( *

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
S
loss/addAdd
loss/sub_1loss/Sum*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/NegNegloss/add*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/ExpExploss/Neg*
T0*#
_output_shapes
:џџџџџџџџџ
Q
loss/add_1/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
W

loss/add_1Addloss/add_1/xloss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
I
loss/LogLog
loss/add_1*
T0*#
_output_shapes
:џџџџџџџџџ
I

loss/Neg_1Negloss/Log*
T0*#
_output_shapes
:џџџџџџџџџ
T

loss/ConstConst*
valueB: *
dtype0*
_output_shapes
:
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
O

loss/pow/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
Y
loss/powPow
loss/users
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_1Const*
valueB"       *
dtype0*
_output_shapes
:
g

loss/Sum_2Sumloss/powloss/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_1/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_2Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_2/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_3Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_4Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_3/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_5Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
T0*
_output_shapes
: 
J

loss/add_4Add
loss/mul_1
loss/add_2*
T0*
_output_shapes
: 
J

loss/add_5Add
loss/add_4
loss/add_3*
T0*
_output_shapes
: 
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
T0*
_output_shapes
: 
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
T
gradients/ConstConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_5_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_5_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1*
T0*
_output_shapes
: 
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0*
_output_shapes
: 
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/pow_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

`
gradients/loss/pow_grad/LogLog
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

у
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1*
T0*
_output_shapes
: 
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_3_grad/LogLogloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1*
T0*
_output_shapes
: 

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_1_grad/LogLogloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/add_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
T0*
out_type0*
_output_shapes
:
^
gradients/loss/Sum_grad/SizeConst*
value	B :*
dtype0*
_output_shapes
: 
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 

gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
dtype0*
_output_shapes
: 

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
N*
T0*#
_output_shapes
:џџџџџџџџџ
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*
T0*#
_output_shapes
:џџџџџџџџџ

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
T0*
_output_shapes
:
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/pos_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/neg_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/mul_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

W
gradients/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/users_grad/ShapeConst*)
_class
loc:@variables/user_factors*
valueB"  
   *
dtype0*
_output_shapes
:
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
T0*
out_type0*
_output_shapes
: 
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/pos_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/neg_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
N*

Tidx0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Y
gradients/concat_3/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
b
GradientDescent/learning_rateConst*
valueB
 *ЭЬЬ=*
dtype0*
_output_shapes
: 
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*)
_class
loc:@variables/user_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/user_factors*
_output_shapes
:	

б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*)
_class
loc:@variables/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/item_factors*
_output_shapes
:	э

М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*&
_class
loc:@variables/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
Tindices0*
use_locking( *
T0*&
_class
loc:@variables/item_bias*
_output_shapes	
:э
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
dtype0*
_output_shapes
: 
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
N*
_output_shapes
: 
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign
j
placeholders_1/sampled_usersPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
n
 placeholders_1/sampled_pos_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
n
 placeholders_1/sampled_neg_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
s
"variables_1/truncated_normal/shapeConst*
valueB"  
   *
dtype0*
_output_shapes
:
f
!variables_1/truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
h
#variables_1/truncated_normal/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
З
,variables_1/truncated_normal/TruncatedNormalTruncatedNormal"variables_1/truncated_normal/shape*
dtype0*
T0*
seedБџх)*
seed2в	*
_output_shapes
:	

Є
 variables_1/truncated_normal/mulMul,variables_1/truncated_normal/TruncatedNormal#variables_1/truncated_normal/stddev*
T0*
_output_shapes
:	


variables_1/truncated_normalAdd variables_1/truncated_normal/mul!variables_1/truncated_normal/mean*
T0*
_output_shapes
:	

u
$variables_1/truncated_normal_1/shapeConst*
valueB"m  
   *
dtype0*
_output_shapes
:
h
#variables_1/truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
j
%variables_1/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
Л
.variables_1/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_1/truncated_normal_1/shape*
dtype0*
T0*
seedБџх)*
seed2в	*
_output_shapes
:	э

Њ
"variables_1/truncated_normal_1/mulMul.variables_1/truncated_normal_1/TruncatedNormal%variables_1/truncated_normal_1/stddev*
T0*
_output_shapes
:	э


variables_1/truncated_normal_1Add"variables_1/truncated_normal_1/mul#variables_1/truncated_normal_1/mean*
T0*
_output_shapes
:	э


variables_1/user_factors
VariableV2*
	container *
shared_name *
dtype0*
shape:	
*
_output_shapes
:	

с
variables_1/user_factors/AssignAssignvariables_1/user_factorsvariables_1/truncated_normal*
use_locking(*+
_class!
loc:@variables_1/user_factors*
T0*
validate_shape(*
_output_shapes
:	


variables_1/user_factors/readIdentityvariables_1/user_factors*+
_class!
loc:@variables_1/user_factors*
T0*
_output_shapes
:	


variables_1/item_factors
VariableV2*
	container *
shared_name *
dtype0*
shape:	э
*
_output_shapes
:	э

у
variables_1/item_factors/AssignAssignvariables_1/item_factorsvariables_1/truncated_normal_1*
use_locking(*+
_class!
loc:@variables_1/item_factors*
T0*
validate_shape(*
_output_shapes
:	э


variables_1/item_factors/readIdentityvariables_1/item_factors*+
_class!
loc:@variables_1/item_factors*
T0*
_output_shapes
:	э

`
variables_1/zerosConst*
valueBэ*    *
dtype0*
_output_shapes	
:э

variables_1/item_bias
VariableV2*
	container *
shared_name *
dtype0*
shape:э*
_output_shapes	
:э
Щ
variables_1/item_bias/AssignAssignvariables_1/item_biasvariables_1/zeros*
use_locking(*(
_class
loc:@variables_1/item_bias*
T0*
validate_shape(*
_output_shapes	
:э

variables_1/item_bias/readIdentityvariables_1/item_bias*(
_class
loc:@variables_1/item_bias*
T0*
_output_shapes	
:э
Г
loss_2/usersGathervariables_1/user_factors/readplaceholders_1/sampled_users*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Л
loss_2/pos_itemsGathervariables_1/item_factors/read placeholders_1/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Л
loss_2/neg_itemsGathervariables_1/item_factors/read placeholders_1/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

И
loss_2/pos_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
И
loss_2/neg_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
g

loss_2/subSubloss_2/pos_itemsloss_2/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

]

loss_2/mulMulloss_2/users
loss_2/sub*
T0*'
_output_shapes
:џџџџџџџџџ

^
loss_2/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 


loss_2/SumSum
loss_2/mulloss_2/Sum/reduction_indices*
	keep_dims( *

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
m
loss_2/sub_1Subloss_2/pos_item_biasloss_2/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Y

loss_2/addAddloss_2/sub_1
loss_2/Sum*
T0*#
_output_shapes
:џџџџџџџџџ
K

loss_2/NegNeg
loss_2/add*
T0*#
_output_shapes
:џџџџџџџџџ
K

loss_2/ExpExp
loss_2/Neg*
T0*#
_output_shapes
:џџџџџџџџџ
S
loss_2/add_1/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
]
loss_2/add_1Addloss_2/add_1/x
loss_2/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
M

loss_2/LogLogloss_2/add_1*
T0*#
_output_shapes
:џџџџџџџџџ
M
loss_2/Neg_1Neg
loss_2/Log*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss_2/ConstConst*
valueB: *
dtype0*
_output_shapes
:
m
loss_2/Sum_1Sumloss_2/Neg_1loss_2/Const*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss_2/pow/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
_

loss_2/powPowloss_2/usersloss_2/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

_
loss_2/Const_1Const*
valueB"       *
dtype0*
_output_shapes
:
m
loss_2/Sum_2Sum
loss_2/powloss_2/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
S
loss_2/mul_1/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
R
loss_2/mul_1Mulloss_2/mul_1/xloss_2/Sum_2*
T0*
_output_shapes
: 
S
loss_2/pow_1/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_1Powloss_2/pos_itemsloss_2/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

_
loss_2/Const_2Const*
valueB"       *
dtype0*
_output_shapes
:
o
loss_2/Sum_3Sumloss_2/pow_1loss_2/Const_2*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
S
loss_2/mul_2/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
R
loss_2/mul_2Mulloss_2/mul_2/xloss_2/Sum_3*
T0*
_output_shapes
: 
S
loss_2/pow_2/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_2Powloss_2/pos_item_biasloss_2/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
X
loss_2/Const_3Const*
valueB: *
dtype0*
_output_shapes
:
o
loss_2/Sum_4Sumloss_2/pow_2loss_2/Const_3*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
P
loss_2/add_2Addloss_2/mul_2loss_2/Sum_4*
T0*
_output_shapes
: 
S
loss_2/pow_3/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_3Powloss_2/neg_itemsloss_2/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

_
loss_2/Const_4Const*
valueB"       *
dtype0*
_output_shapes
:
o
loss_2/Sum_5Sumloss_2/pow_3loss_2/Const_4*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
S
loss_2/mul_3/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
R
loss_2/mul_3Mulloss_2/mul_3/xloss_2/Sum_5*
T0*
_output_shapes
: 
S
loss_2/pow_4/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
g
loss_2/pow_4Powloss_2/neg_item_biasloss_2/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
X
loss_2/Const_5Const*
valueB: *
dtype0*
_output_shapes
:
o
loss_2/Sum_6Sumloss_2/pow_4loss_2/Const_5*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
P
loss_2/add_3Addloss_2/mul_3loss_2/Sum_6*
T0*
_output_shapes
: 
P
loss_2/add_4Addloss_2/mul_1loss_2/add_2*
T0*
_output_shapes
: 
P
loss_2/add_5Addloss_2/add_4loss_2/add_3*
T0*
_output_shapes
: 
P
loss_2/sub_2Subloss_2/add_5loss_2/Sum_1*
T0*
_output_shapes
: 
T
gradients_1/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
V
gradients_1/ConstConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
_
gradients_1/FillFillgradients_1/Shapegradients_1/Const*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/sub_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/sub_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_2_grad/Shape%gradients_1/loss_2/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Џ
!gradients_1/loss_2/sub_2_grad/SumSumgradients_1/Fill3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/sub_2_grad/ReshapeReshape!gradients_1/loss_2/sub_2_grad/Sum#gradients_1/loss_2/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Г
#gradients_1/loss_2/sub_2_grad/Sum_1Sumgradients_1/Fill5gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
p
!gradients_1/loss_2/sub_2_grad/NegNeg#gradients_1/loss_2/sub_2_grad/Sum_1*
T0*
_output_shapes
:
Ћ
'gradients_1/loss_2/sub_2_grad/Reshape_1Reshape!gradients_1/loss_2/sub_2_grad/Neg%gradients_1/loss_2/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/sub_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_2_grad/Reshape(^gradients_1/loss_2/sub_2_grad/Reshape_1
ѕ
6gradients_1/loss_2/sub_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_2_grad/Reshape/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/sub_2_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_2_grad/Reshape_1/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/sub_2_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_5_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_5_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_5_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_5_grad/Shape%gradients_1/loss_2/add_5_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
е
!gradients_1/loss_2/add_5_grad/SumSum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency3gradients_1/loss_2/add_5_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_5_grad/ReshapeReshape!gradients_1/loss_2/add_5_grad/Sum#gradients_1/loss_2/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
й
#gradients_1/loss_2/add_5_grad/Sum_1Sum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency5gradients_1/loss_2/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_5_grad/Reshape_1Reshape#gradients_1/loss_2/add_5_grad/Sum_1%gradients_1/loss_2/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_5_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_5_grad/Reshape(^gradients_1/loss_2/add_5_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_5_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_5_grad/Reshape/^gradients_1/loss_2/add_5_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_5_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_5_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_5_grad/Reshape_1/^gradients_1/loss_2/add_5_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_5_grad/Reshape_1*
T0*
_output_shapes
: 
u
+gradients_1/loss_2/Sum_1_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
Ъ
%gradients_1/loss_2/Sum_1_grad/ReshapeReshape8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
o
#gradients_1/loss_2/Sum_1_grad/ShapeShapeloss_2/Neg_1*
T0*
out_type0*
_output_shapes
:
Ж
"gradients_1/loss_2/Sum_1_grad/TileTile%gradients_1/loss_2/Sum_1_grad/Reshape#gradients_1/loss_2/Sum_1_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
f
#gradients_1/loss_2/add_4_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_4_grad/Shape%gradients_1/loss_2/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
е
!gradients_1/loss_2/add_4_grad/SumSum6gradients_1/loss_2/add_5_grad/tuple/control_dependency3gradients_1/loss_2/add_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_4_grad/ReshapeReshape!gradients_1/loss_2/add_4_grad/Sum#gradients_1/loss_2/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
й
#gradients_1/loss_2/add_4_grad/Sum_1Sum6gradients_1/loss_2/add_5_grad/tuple/control_dependency5gradients_1/loss_2/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_4_grad/Reshape_1Reshape#gradients_1/loss_2/add_4_grad/Sum_1%gradients_1/loss_2/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_4_grad/Reshape(^gradients_1/loss_2/add_4_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_4_grad/Reshape/^gradients_1/loss_2/add_4_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_4_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_4_grad/Reshape_1/^gradients_1/loss_2/add_4_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_4_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_3_grad/Shape%gradients_1/loss_2/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
з
!gradients_1/loss_2/add_3_grad/SumSum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_13gradients_1/loss_2/add_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_3_grad/ReshapeReshape!gradients_1/loss_2/add_3_grad/Sum#gradients_1/loss_2/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
л
#gradients_1/loss_2/add_3_grad/Sum_1Sum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_15gradients_1/loss_2/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_3_grad/Reshape_1Reshape#gradients_1/loss_2/add_3_grad/Sum_1%gradients_1/loss_2/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_3_grad/Reshape(^gradients_1/loss_2/add_3_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_3_grad/Reshape/^gradients_1/loss_2/add_3_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_3_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_3_grad/Reshape_1/^gradients_1/loss_2/add_3_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_3_grad/Reshape_1*
T0*
_output_shapes
: 
z
!gradients_1/loss_2/Neg_1_grad/NegNeg"gradients_1/loss_2/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ
f
#gradients_1/loss_2/mul_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/mul_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_1_grad/Shape%gradients_1/loss_2/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/mul_1_grad/mulMul6gradients_1/loss_2/add_4_grad/tuple/control_dependencyloss_2/Sum_2*
T0*
_output_shapes
: 
Р
!gradients_1/loss_2/mul_1_grad/SumSum!gradients_1/loss_2/mul_1_grad/mul3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/mul_1_grad/ReshapeReshape!gradients_1/loss_2/mul_1_grad/Sum#gradients_1/loss_2/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

#gradients_1/loss_2/mul_1_grad/mul_1Mulloss_2/mul_1/x6gradients_1/loss_2/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
Ц
#gradients_1/loss_2/mul_1_grad/Sum_1Sum#gradients_1/loss_2/mul_1_grad/mul_15gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/mul_1_grad/Reshape_1Reshape#gradients_1/loss_2/mul_1_grad/Sum_1%gradients_1/loss_2/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/mul_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_1_grad/Reshape(^gradients_1/loss_2/mul_1_grad/Reshape_1
ѕ
6gradients_1/loss_2/mul_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_1_grad/Reshape/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_1_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_1_grad/Reshape_1/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/mul_1_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/add_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_2_grad/Shape%gradients_1/loss_2/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
з
!gradients_1/loss_2/add_2_grad/SumSum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_13gradients_1/loss_2/add_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_2_grad/ReshapeReshape!gradients_1/loss_2/add_2_grad/Sum#gradients_1/loss_2/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
л
#gradients_1/loss_2/add_2_grad/Sum_1Sum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_15gradients_1/loss_2/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/add_2_grad/Reshape_1Reshape#gradients_1/loss_2/add_2_grad/Sum_1%gradients_1/loss_2/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/add_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_2_grad/Reshape(^gradients_1/loss_2/add_2_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_2_grad/Reshape/^gradients_1/loss_2/add_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_2_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_2_grad/Reshape_1/^gradients_1/loss_2/add_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_2_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/mul_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/mul_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_3_grad/Shape%gradients_1/loss_2/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/mul_3_grad/mulMul6gradients_1/loss_2/add_3_grad/tuple/control_dependencyloss_2/Sum_5*
T0*
_output_shapes
: 
Р
!gradients_1/loss_2/mul_3_grad/SumSum!gradients_1/loss_2/mul_3_grad/mul3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/mul_3_grad/ReshapeReshape!gradients_1/loss_2/mul_3_grad/Sum#gradients_1/loss_2/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

#gradients_1/loss_2/mul_3_grad/mul_1Mulloss_2/mul_3/x6gradients_1/loss_2/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
Ц
#gradients_1/loss_2/mul_3_grad/Sum_1Sum#gradients_1/loss_2/mul_3_grad/mul_15gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/mul_3_grad/Reshape_1Reshape#gradients_1/loss_2/mul_3_grad/Sum_1%gradients_1/loss_2/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/mul_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_3_grad/Reshape(^gradients_1/loss_2/mul_3_grad/Reshape_1
ѕ
6gradients_1/loss_2/mul_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_3_grad/Reshape/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_3_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_3_grad/Reshape_1/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/mul_3_grad/Reshape_1*
T0*
_output_shapes
: 
u
+gradients_1/loss_2/Sum_6_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
Ъ
%gradients_1/loss_2/Sum_6_grad/ReshapeReshape8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
o
#gradients_1/loss_2/Sum_6_grad/ShapeShapeloss_2/pow_4*
T0*
out_type0*
_output_shapes
:
Ж
"gradients_1/loss_2/Sum_6_grad/TileTile%gradients_1/loss_2/Sum_6_grad/Reshape#gradients_1/loss_2/Sum_6_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ

&gradients_1/loss_2/Log_grad/Reciprocal
Reciprocalloss_2/add_1"^gradients_1/loss_2/Neg_1_grad/Neg*
T0*#
_output_shapes
:џџџџџџџџџ

gradients_1/loss_2/Log_grad/mulMul!gradients_1/loss_2/Neg_1_grad/Neg&gradients_1/loss_2/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
|
+gradients_1/loss_2/Sum_2_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Ю
%gradients_1/loss_2/Sum_2_grad/ReshapeReshape8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
m
#gradients_1/loss_2/Sum_2_grad/ShapeShape
loss_2/pow*
T0*
out_type0*
_output_shapes
:
К
"gradients_1/loss_2/Sum_2_grad/TileTile%gradients_1/loss_2/Sum_2_grad/Reshape#gradients_1/loss_2/Sum_2_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

f
#gradients_1/loss_2/mul_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
h
%gradients_1/loss_2/mul_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_2_grad/Shape%gradients_1/loss_2/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/mul_2_grad/mulMul6gradients_1/loss_2/add_2_grad/tuple/control_dependencyloss_2/Sum_3*
T0*
_output_shapes
: 
Р
!gradients_1/loss_2/mul_2_grad/SumSum!gradients_1/loss_2/mul_2_grad/mul3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/mul_2_grad/ReshapeReshape!gradients_1/loss_2/mul_2_grad/Sum#gradients_1/loss_2/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

#gradients_1/loss_2/mul_2_grad/mul_1Mulloss_2/mul_2/x6gradients_1/loss_2/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
Ц
#gradients_1/loss_2/mul_2_grad/Sum_1Sum#gradients_1/loss_2/mul_2_grad/mul_15gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/mul_2_grad/Reshape_1Reshape#gradients_1/loss_2/mul_2_grad/Sum_1%gradients_1/loss_2/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/mul_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_2_grad/Reshape(^gradients_1/loss_2/mul_2_grad/Reshape_1
ѕ
6gradients_1/loss_2/mul_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_2_grad/Reshape/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_2_grad/Reshape*
T0*
_output_shapes
: 
ћ
8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_2_grad/Reshape_1/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/mul_2_grad/Reshape_1*
T0*
_output_shapes
: 
u
+gradients_1/loss_2/Sum_4_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
Ъ
%gradients_1/loss_2/Sum_4_grad/ReshapeReshape8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
o
#gradients_1/loss_2/Sum_4_grad/ShapeShapeloss_2/pow_2*
T0*
out_type0*
_output_shapes
:
Ж
"gradients_1/loss_2/Sum_4_grad/TileTile%gradients_1/loss_2/Sum_4_grad/Reshape#gradients_1/loss_2/Sum_4_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
|
+gradients_1/loss_2/Sum_5_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Ю
%gradients_1/loss_2/Sum_5_grad/ReshapeReshape8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
o
#gradients_1/loss_2/Sum_5_grad/ShapeShapeloss_2/pow_3*
T0*
out_type0*
_output_shapes
:
К
"gradients_1/loss_2/Sum_5_grad/TileTile%gradients_1/loss_2/Sum_5_grad/Reshape#gradients_1/loss_2/Sum_5_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

w
#gradients_1/loss_2/pow_4_grad/ShapeShapeloss_2/neg_item_bias*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_4_grad/Shape%gradients_1/loss_2/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_4_grad/mulMul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
h
#gradients_1/loss_2/pow_4_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_4_grad/subSubloss_2/pow_4/y#gradients_1/loss_2/pow_4_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_4_grad/PowPowloss_2/neg_item_bias!gradients_1/loss_2/pow_4_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_4_grad/mul_1Mul!gradients_1/loss_2/pow_4_grad/mul!gradients_1/loss_2/pow_4_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Т
!gradients_1/loss_2/pow_4_grad/SumSum#gradients_1/loss_2/pow_4_grad/mul_13gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/pow_4_grad/ReshapeReshape!gradients_1/loss_2/pow_4_grad/Sum#gradients_1/loss_2/pow_4_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
l
'gradients_1/loss_2/pow_4_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_4_grad/GreaterGreaterloss_2/neg_item_bias'gradients_1/loss_2/pow_4_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
l
!gradients_1/loss_2/pow_4_grad/LogLogloss_2/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
y
(gradients_1/loss_2/pow_4_grad/zeros_like	ZerosLikeloss_2/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
а
$gradients_1/loss_2/pow_4_grad/SelectSelect%gradients_1/loss_2/pow_4_grad/Greater!gradients_1/loss_2/pow_4_grad/Log(gradients_1/loss_2/pow_4_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_4_grad/mul_2Mul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4*
T0*#
_output_shapes
:џџџџџџџџџ
Ѓ
#gradients_1/loss_2/pow_4_grad/mul_3Mul#gradients_1/loss_2/pow_4_grad/mul_2$gradients_1/loss_2/pow_4_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
Ц
#gradients_1/loss_2/pow_4_grad/Sum_1Sum#gradients_1/loss_2/pow_4_grad/mul_35gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_4_grad/Reshape_1Reshape#gradients_1/loss_2/pow_4_grad/Sum_1%gradients_1/loss_2/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_4_grad/Reshape(^gradients_1/loss_2/pow_4_grad/Reshape_1

6gradients_1/loss_2/pow_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_4_grad/Reshape/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ћ
8gradients_1/loss_2/pow_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_4_grad/Reshape_1/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_4_grad/Reshape_1*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/add_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
o
%gradients_1/loss_2/add_1_grad/Shape_1Shape
loss_2/Exp*
T0*
out_type0*
_output_shapes
:
е
3gradients_1/loss_2/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_1_grad/Shape%gradients_1/loss_2/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
О
!gradients_1/loss_2/add_1_grad/SumSumgradients_1/loss_2/Log_grad/mul3gradients_1/loss_2/add_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/add_1_grad/ReshapeReshape!gradients_1/loss_2/add_1_grad/Sum#gradients_1/loss_2/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Т
#gradients_1/loss_2/add_1_grad/Sum_1Sumgradients_1/loss_2/Log_grad/mul5gradients_1/loss_2/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
К
'gradients_1/loss_2/add_1_grad/Reshape_1Reshape#gradients_1/loss_2/add_1_grad/Sum_1%gradients_1/loss_2/add_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ

.gradients_1/loss_2/add_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_1_grad/Reshape(^gradients_1/loss_2/add_1_grad/Reshape_1
ѕ
6gradients_1/loss_2/add_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_1_grad/Reshape/^gradients_1/loss_2/add_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_1_grad/Reshape*
T0*
_output_shapes
: 

8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_1_grad/Reshape_1/^gradients_1/loss_2/add_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/add_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
m
!gradients_1/loss_2/pow_grad/ShapeShapeloss_2/users*
T0*
out_type0*
_output_shapes
:
f
#gradients_1/loss_2/pow_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Я
1gradients_1/loss_2/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/pow_grad/Shape#gradients_1/loss_2/pow_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients_1/loss_2/pow_grad/mulMul"gradients_1/loss_2/Sum_2_grad/Tileloss_2/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
!gradients_1/loss_2/pow_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
x
gradients_1/loss_2/pow_grad/subSubloss_2/pow/y!gradients_1/loss_2/pow_grad/sub/y*
T0*
_output_shapes
: 

gradients_1/loss_2/pow_grad/PowPowloss_2/usersgradients_1/loss_2/pow_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


!gradients_1/loss_2/pow_grad/mul_1Mulgradients_1/loss_2/pow_grad/mulgradients_1/loss_2/pow_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

М
gradients_1/loss_2/pow_grad/SumSum!gradients_1/loss_2/pow_grad/mul_11gradients_1/loss_2/pow_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
В
#gradients_1/loss_2/pow_grad/ReshapeReshapegradients_1/loss_2/pow_grad/Sum!gradients_1/loss_2/pow_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

j
%gradients_1/loss_2/pow_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

#gradients_1/loss_2/pow_grad/GreaterGreaterloss_2/users%gradients_1/loss_2/pow_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients_1/loss_2/pow_grad/LogLogloss_2/users*
T0*'
_output_shapes
:џџџџџџџџџ

s
&gradients_1/loss_2/pow_grad/zeros_like	ZerosLikeloss_2/users*
T0*'
_output_shapes
:џџџџџџџџџ

Ь
"gradients_1/loss_2/pow_grad/SelectSelect#gradients_1/loss_2/pow_grad/Greatergradients_1/loss_2/pow_grad/Log&gradients_1/loss_2/pow_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


!gradients_1/loss_2/pow_grad/mul_2Mul"gradients_1/loss_2/Sum_2_grad/Tile
loss_2/pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ё
!gradients_1/loss_2/pow_grad/mul_3Mul!gradients_1/loss_2/pow_grad/mul_2"gradients_1/loss_2/pow_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Р
!gradients_1/loss_2/pow_grad/Sum_1Sum!gradients_1/loss_2/pow_grad/mul_33gradients_1/loss_2/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ї
%gradients_1/loss_2/pow_grad/Reshape_1Reshape!gradients_1/loss_2/pow_grad/Sum_1#gradients_1/loss_2/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

,gradients_1/loss_2/pow_grad/tuple/group_depsNoOp$^gradients_1/loss_2/pow_grad/Reshape&^gradients_1/loss_2/pow_grad/Reshape_1
ў
4gradients_1/loss_2/pow_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/pow_grad/Reshape-^gradients_1/loss_2/pow_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ѓ
6gradients_1/loss_2/pow_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/pow_grad/Reshape_1-^gradients_1/loss_2/pow_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_grad/Reshape_1*
T0*
_output_shapes
: 
|
+gradients_1/loss_2/Sum_3_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Ю
%gradients_1/loss_2/Sum_3_grad/ReshapeReshape8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
o
#gradients_1/loss_2/Sum_3_grad/ShapeShapeloss_2/pow_1*
T0*
out_type0*
_output_shapes
:
К
"gradients_1/loss_2/Sum_3_grad/TileTile%gradients_1/loss_2/Sum_3_grad/Reshape#gradients_1/loss_2/Sum_3_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

w
#gradients_1/loss_2/pow_2_grad/ShapeShapeloss_2/pos_item_bias*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_2_grad/Shape%gradients_1/loss_2/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_2_grad/mulMul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
h
#gradients_1/loss_2/pow_2_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_2_grad/subSubloss_2/pow_2/y#gradients_1/loss_2/pow_2_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_2_grad/PowPowloss_2/pos_item_bias!gradients_1/loss_2/pow_2_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_2_grad/mul_1Mul!gradients_1/loss_2/pow_2_grad/mul!gradients_1/loss_2/pow_2_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Т
!gradients_1/loss_2/pow_2_grad/SumSum#gradients_1/loss_2/pow_2_grad/mul_13gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/pow_2_grad/ReshapeReshape!gradients_1/loss_2/pow_2_grad/Sum#gradients_1/loss_2/pow_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
l
'gradients_1/loss_2/pow_2_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_2_grad/GreaterGreaterloss_2/pos_item_bias'gradients_1/loss_2/pow_2_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
l
!gradients_1/loss_2/pow_2_grad/LogLogloss_2/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
y
(gradients_1/loss_2/pow_2_grad/zeros_like	ZerosLikeloss_2/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
а
$gradients_1/loss_2/pow_2_grad/SelectSelect%gradients_1/loss_2/pow_2_grad/Greater!gradients_1/loss_2/pow_2_grad/Log(gradients_1/loss_2/pow_2_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

#gradients_1/loss_2/pow_2_grad/mul_2Mul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2*
T0*#
_output_shapes
:џџџџџџџџџ
Ѓ
#gradients_1/loss_2/pow_2_grad/mul_3Mul#gradients_1/loss_2/pow_2_grad/mul_2$gradients_1/loss_2/pow_2_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
Ц
#gradients_1/loss_2/pow_2_grad/Sum_1Sum#gradients_1/loss_2/pow_2_grad/mul_35gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_2_grad/Reshape_1Reshape#gradients_1/loss_2/pow_2_grad/Sum_1%gradients_1/loss_2/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_2_grad/Reshape(^gradients_1/loss_2/pow_2_grad/Reshape_1

6gradients_1/loss_2/pow_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_2_grad/Reshape/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ћ
8gradients_1/loss_2/pow_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_2_grad/Reshape_1/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_2_grad/Reshape_1*
T0*
_output_shapes
: 
s
#gradients_1/loss_2/pow_3_grad/ShapeShapeloss_2/neg_items*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_3_grad/Shape%gradients_1/loss_2/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_3_grad/mulMul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

h
#gradients_1/loss_2/pow_3_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_3_grad/subSubloss_2/pow_3/y#gradients_1/loss_2/pow_3_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_3_grad/PowPowloss_2/neg_items!gradients_1/loss_2/pow_3_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ђ
#gradients_1/loss_2/pow_3_grad/mul_1Mul!gradients_1/loss_2/pow_3_grad/mul!gradients_1/loss_2/pow_3_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Т
!gradients_1/loss_2/pow_3_grad/SumSum#gradients_1/loss_2/pow_3_grad/mul_13gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
И
%gradients_1/loss_2/pow_3_grad/ReshapeReshape!gradients_1/loss_2/pow_3_grad/Sum#gradients_1/loss_2/pow_3_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

l
'gradients_1/loss_2/pow_3_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_3_grad/GreaterGreaterloss_2/neg_items'gradients_1/loss_2/pow_3_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

l
!gradients_1/loss_2/pow_3_grad/LogLogloss_2/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

y
(gradients_1/loss_2/pow_3_grad/zeros_like	ZerosLikeloss_2/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

д
$gradients_1/loss_2/pow_3_grad/SelectSelect%gradients_1/loss_2/pow_3_grad/Greater!gradients_1/loss_2/pow_3_grad/Log(gradients_1/loss_2/pow_3_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients_1/loss_2/pow_3_grad/mul_2Mul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3*
T0*'
_output_shapes
:џџџџџџџџџ

Ї
#gradients_1/loss_2/pow_3_grad/mul_3Mul#gradients_1/loss_2/pow_3_grad/mul_2$gradients_1/loss_2/pow_3_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Ц
#gradients_1/loss_2/pow_3_grad/Sum_1Sum#gradients_1/loss_2/pow_3_grad/mul_35gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_3_grad/Reshape_1Reshape#gradients_1/loss_2/pow_3_grad/Sum_1%gradients_1/loss_2/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_3_grad/Reshape(^gradients_1/loss_2/pow_3_grad/Reshape_1

6gradients_1/loss_2/pow_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_3_grad/Reshape/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ћ
8gradients_1/loss_2/pow_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_3_grad/Reshape_1/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_3_grad/Reshape_1*
T0*
_output_shapes
: 

gradients_1/loss_2/Exp_grad/mulMul8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1
loss_2/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
s
#gradients_1/loss_2/pow_1_grad/ShapeShapeloss_2/pos_items*
T0*
out_type0*
_output_shapes
:
h
%gradients_1/loss_2/pow_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
е
3gradients_1/loss_2/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_1_grad/Shape%gradients_1/loss_2/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

!gradients_1/loss_2/pow_1_grad/mulMul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

h
#gradients_1/loss_2/pow_1_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
~
!gradients_1/loss_2/pow_1_grad/subSubloss_2/pow_1/y#gradients_1/loss_2/pow_1_grad/sub/y*
T0*
_output_shapes
: 

!gradients_1/loss_2/pow_1_grad/PowPowloss_2/pos_items!gradients_1/loss_2/pow_1_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ђ
#gradients_1/loss_2/pow_1_grad/mul_1Mul!gradients_1/loss_2/pow_1_grad/mul!gradients_1/loss_2/pow_1_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Т
!gradients_1/loss_2/pow_1_grad/SumSum#gradients_1/loss_2/pow_1_grad/mul_13gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
И
%gradients_1/loss_2/pow_1_grad/ReshapeReshape!gradients_1/loss_2/pow_1_grad/Sum#gradients_1/loss_2/pow_1_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

l
'gradients_1/loss_2/pow_1_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

%gradients_1/loss_2/pow_1_grad/GreaterGreaterloss_2/pos_items'gradients_1/loss_2/pow_1_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

l
!gradients_1/loss_2/pow_1_grad/LogLogloss_2/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

y
(gradients_1/loss_2/pow_1_grad/zeros_like	ZerosLikeloss_2/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

д
$gradients_1/loss_2/pow_1_grad/SelectSelect%gradients_1/loss_2/pow_1_grad/Greater!gradients_1/loss_2/pow_1_grad/Log(gradients_1/loss_2/pow_1_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients_1/loss_2/pow_1_grad/mul_2Mul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1*
T0*'
_output_shapes
:џџџџџџџџџ

Ї
#gradients_1/loss_2/pow_1_grad/mul_3Mul#gradients_1/loss_2/pow_1_grad/mul_2$gradients_1/loss_2/pow_1_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Ц
#gradients_1/loss_2/pow_1_grad/Sum_1Sum#gradients_1/loss_2/pow_1_grad/mul_35gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
­
'gradients_1/loss_2/pow_1_grad/Reshape_1Reshape#gradients_1/loss_2/pow_1_grad/Sum_1%gradients_1/loss_2/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 

.gradients_1/loss_2/pow_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_1_grad/Reshape(^gradients_1/loss_2/pow_1_grad/Reshape_1

6gradients_1/loss_2/pow_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_1_grad/Reshape/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ћ
8gradients_1/loss_2/pow_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_1_grad/Reshape_1/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/pow_1_grad/Reshape_1*
T0*
_output_shapes
: 
u
gradients_1/loss_2/Neg_grad/NegNeggradients_1/loss_2/Exp_grad/mul*
T0*#
_output_shapes
:џџџџџџџџџ
m
!gradients_1/loss_2/add_grad/ShapeShapeloss_2/sub_1*
T0*
out_type0*
_output_shapes
:
m
#gradients_1/loss_2/add_grad/Shape_1Shape
loss_2/Sum*
T0*
out_type0*
_output_shapes
:
Я
1gradients_1/loss_2/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/add_grad/Shape#gradients_1/loss_2/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
К
gradients_1/loss_2/add_grad/SumSumgradients_1/loss_2/Neg_grad/Neg1gradients_1/loss_2/add_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ў
#gradients_1/loss_2/add_grad/ReshapeReshapegradients_1/loss_2/add_grad/Sum!gradients_1/loss_2/add_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
О
!gradients_1/loss_2/add_grad/Sum_1Sumgradients_1/loss_2/Neg_grad/Neg3gradients_1/loss_2/add_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/add_grad/Reshape_1Reshape!gradients_1/loss_2/add_grad/Sum_1#gradients_1/loss_2/add_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ

,gradients_1/loss_2/add_grad/tuple/group_depsNoOp$^gradients_1/loss_2/add_grad/Reshape&^gradients_1/loss_2/add_grad/Reshape_1
њ
4gradients_1/loss_2/add_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/add_grad/Reshape-^gradients_1/loss_2/add_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/add_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

6gradients_1/loss_2/add_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/add_grad/Reshape_1-^gradients_1/loss_2/add_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/add_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
w
#gradients_1/loss_2/sub_1_grad/ShapeShapeloss_2/pos_item_bias*
T0*
out_type0*
_output_shapes
:
y
%gradients_1/loss_2/sub_1_grad/Shape_1Shapeloss_2/neg_item_bias*
T0*
out_type0*
_output_shapes
:
е
3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_1_grad/Shape%gradients_1/loss_2/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
г
!gradients_1/loss_2/sub_1_grad/SumSum4gradients_1/loss_2/add_grad/tuple/control_dependency3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Д
%gradients_1/loss_2/sub_1_grad/ReshapeReshape!gradients_1/loss_2/sub_1_grad/Sum#gradients_1/loss_2/sub_1_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
з
#gradients_1/loss_2/sub_1_grad/Sum_1Sum4gradients_1/loss_2/add_grad/tuple/control_dependency5gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
p
!gradients_1/loss_2/sub_1_grad/NegNeg#gradients_1/loss_2/sub_1_grad/Sum_1*
T0*
_output_shapes
:
И
'gradients_1/loss_2/sub_1_grad/Reshape_1Reshape!gradients_1/loss_2/sub_1_grad/Neg%gradients_1/loss_2/sub_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ

.gradients_1/loss_2/sub_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_1_grad/Reshape(^gradients_1/loss_2/sub_1_grad/Reshape_1

6gradients_1/loss_2/sub_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_1_grad/Reshape/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/sub_1_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_1_grad/Reshape_1/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*:
_class0
.,loc:@gradients_1/loss_2/sub_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
k
!gradients_1/loss_2/Sum_grad/ShapeShape
loss_2/mul*
T0*
out_type0*
_output_shapes
:
b
 gradients_1/loss_2/Sum_grad/SizeConst*
value	B :*
dtype0*
_output_shapes
: 

gradients_1/loss_2/Sum_grad/addAddloss_2/Sum/reduction_indices gradients_1/loss_2/Sum_grad/Size*
T0*
_output_shapes
: 

gradients_1/loss_2/Sum_grad/modFloorModgradients_1/loss_2/Sum_grad/add gradients_1/loss_2/Sum_grad/Size*
T0*
_output_shapes
: 
f
#gradients_1/loss_2/Sum_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
i
'gradients_1/loss_2/Sum_grad/range/startConst*
value	B : *
dtype0*
_output_shapes
: 
i
'gradients_1/loss_2/Sum_grad/range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
Ц
!gradients_1/loss_2/Sum_grad/rangeRange'gradients_1/loss_2/Sum_grad/range/start gradients_1/loss_2/Sum_grad/Size'gradients_1/loss_2/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
h
&gradients_1/loss_2/Sum_grad/Fill/valueConst*
value	B :*
dtype0*
_output_shapes
: 

 gradients_1/loss_2/Sum_grad/FillFill#gradients_1/loss_2/Sum_grad/Shape_1&gradients_1/loss_2/Sum_grad/Fill/value*
T0*
_output_shapes
: 
њ
)gradients_1/loss_2/Sum_grad/DynamicStitchDynamicStitch!gradients_1/loss_2/Sum_grad/rangegradients_1/loss_2/Sum_grad/mod!gradients_1/loss_2/Sum_grad/Shape gradients_1/loss_2/Sum_grad/Fill*
N*
T0*#
_output_shapes
:џџџџџџџџџ
g
%gradients_1/loss_2/Sum_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
Ў
#gradients_1/loss_2/Sum_grad/MaximumMaximum)gradients_1/loss_2/Sum_grad/DynamicStitch%gradients_1/loss_2/Sum_grad/Maximum/y*
T0*#
_output_shapes
:џџџџџџџџџ

$gradients_1/loss_2/Sum_grad/floordivFloorDiv!gradients_1/loss_2/Sum_grad/Shape#gradients_1/loss_2/Sum_grad/Maximum*
T0*
_output_shapes
:
Т
#gradients_1/loss_2/Sum_grad/ReshapeReshape6gradients_1/loss_2/add_grad/tuple/control_dependency_1)gradients_1/loss_2/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
З
 gradients_1/loss_2/Sum_grad/TileTile#gradients_1/loss_2/Sum_grad/Reshape$gradients_1/loss_2/Sum_grad/floordiv*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

љ
gradients_1/AddNAddN6gradients_1/loss_2/pow_2_grad/tuple/control_dependency6gradients_1/loss_2/sub_1_grad/tuple/control_dependency*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
 
+gradients_1/loss_2/pos_item_bias_grad/ShapeConst*(
_class
loc:@variables_1/item_bias*
valueB:э*
dtype0*
_output_shapes
:

*gradients_1/loss_2/pos_item_bias_grad/SizeSize placeholders_1/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
v
4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
б
0gradients_1/loss_2/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/pos_item_bias_grad/Size4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Й
3gradients_1/loss_2/pos_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/pos_item_bias_grad/Shape9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
s
1gradients_1/loss_2/pos_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 

,gradients_1/loss_2/pos_item_bias_grad/concatConcatV20gradients_1/loss_2/pos_item_bias_grad/ExpandDims3gradients_1/loss_2/pos_item_bias_grad/strided_slice1gradients_1/loss_2/pos_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Д
-gradients_1/loss_2/pos_item_bias_grad/ReshapeReshapegradients_1/AddN,gradients_1/loss_2/pos_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ъ
/gradients_1/loss_2/pos_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_pos_items0gradients_1/loss_2/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
§
gradients_1/AddN_1AddN6gradients_1/loss_2/pow_4_grad/tuple/control_dependency8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
 
+gradients_1/loss_2/neg_item_bias_grad/ShapeConst*(
_class
loc:@variables_1/item_bias*
valueB:э*
dtype0*
_output_shapes
:

*gradients_1/loss_2/neg_item_bias_grad/SizeSize placeholders_1/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
v
4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
б
0gradients_1/loss_2/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/neg_item_bias_grad/Size4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Й
3gradients_1/loss_2/neg_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/neg_item_bias_grad/Shape9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
s
1gradients_1/loss_2/neg_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 

,gradients_1/loss_2/neg_item_bias_grad/concatConcatV20gradients_1/loss_2/neg_item_bias_grad/ExpandDims3gradients_1/loss_2/neg_item_bias_grad/strided_slice1gradients_1/loss_2/neg_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Ж
-gradients_1/loss_2/neg_item_bias_grad/ReshapeReshapegradients_1/AddN_1,gradients_1/loss_2/neg_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ъ
/gradients_1/loss_2/neg_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_neg_items0gradients_1/loss_2/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
m
!gradients_1/loss_2/mul_grad/ShapeShapeloss_2/users*
T0*
out_type0*
_output_shapes
:
m
#gradients_1/loss_2/mul_grad/Shape_1Shape
loss_2/sub*
T0*
out_type0*
_output_shapes
:
Я
1gradients_1/loss_2/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/mul_grad/Shape#gradients_1/loss_2/mul_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients_1/loss_2/mul_grad/mulMul gradients_1/loss_2/Sum_grad/Tile
loss_2/sub*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients_1/loss_2/mul_grad/SumSumgradients_1/loss_2/mul_grad/mul1gradients_1/loss_2/mul_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
В
#gradients_1/loss_2/mul_grad/ReshapeReshapegradients_1/loss_2/mul_grad/Sum!gradients_1/loss_2/mul_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


!gradients_1/loss_2/mul_grad/mul_1Mulloss_2/users gradients_1/loss_2/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Р
!gradients_1/loss_2/mul_grad/Sum_1Sum!gradients_1/loss_2/mul_grad/mul_13gradients_1/loss_2/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
И
%gradients_1/loss_2/mul_grad/Reshape_1Reshape!gradients_1/loss_2/mul_grad/Sum_1#gradients_1/loss_2/mul_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


,gradients_1/loss_2/mul_grad/tuple/group_depsNoOp$^gradients_1/loss_2/mul_grad/Reshape&^gradients_1/loss_2/mul_grad/Reshape_1
ў
4gradients_1/loss_2/mul_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/mul_grad/Reshape-^gradients_1/loss_2/mul_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/mul_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


6gradients_1/loss_2/mul_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/mul_grad/Reshape_1-^gradients_1/loss_2/mul_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/mul_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

Y
gradients_1/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
и
gradients_1/concatConcatV2-gradients_1/loss_2/pos_item_bias_grad/Reshape-gradients_1/loss_2/neg_item_bias_grad/Reshapegradients_1/concat/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
[
gradients_1/concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
р
gradients_1/concat_1ConcatV2/gradients_1/loss_2/pos_item_bias_grad/Reshape_1/gradients_1/loss_2/neg_item_bias_grad/Reshape_1gradients_1/concat_1/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
љ
gradients_1/AddN_2AddN4gradients_1/loss_2/pow_grad/tuple/control_dependency4gradients_1/loss_2/mul_grad/tuple/control_dependency*
N*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

Ё
#gradients_1/loss_2/users_grad/ShapeConst*+
_class!
loc:@variables_1/user_factors*
valueB"  
   *
dtype0*
_output_shapes
:
y
"gradients_1/loss_2/users_grad/SizeSizeplaceholders_1/sampled_users*
T0*
out_type0*
_output_shapes
: 
n
,gradients_1/loss_2/users_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients_1/loss_2/users_grad/ExpandDims
ExpandDims"gradients_1/loss_2/users_grad/Size,gradients_1/loss_2/users_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients_1/loss_2/users_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients_1/loss_2/users_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients_1/loss_2/users_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients_1/loss_2/users_grad/strided_sliceStridedSlice#gradients_1/loss_2/users_grad/Shape1gradients_1/loss_2/users_grad/strided_slice/stack3gradients_1/loss_2/users_grad/strided_slice/stack_13gradients_1/loss_2/users_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients_1/loss_2/users_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients_1/loss_2/users_grad/concatConcatV2(gradients_1/loss_2/users_grad/ExpandDims+gradients_1/loss_2/users_grad/strided_slice)gradients_1/loss_2/users_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Г
%gradients_1/loss_2/users_grad/ReshapeReshapegradients_1/AddN_2$gradients_1/loss_2/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ж
'gradients_1/loss_2/users_grad/Reshape_1Reshapeplaceholders_1/sampled_users(gradients_1/loss_2/users_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
q
!gradients_1/loss_2/sub_grad/ShapeShapeloss_2/pos_items*
T0*
out_type0*
_output_shapes
:
s
#gradients_1/loss_2/sub_grad/Shape_1Shapeloss_2/neg_items*
T0*
out_type0*
_output_shapes
:
Я
1gradients_1/loss_2/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/sub_grad/Shape#gradients_1/loss_2/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
б
gradients_1/loss_2/sub_grad/SumSum6gradients_1/loss_2/mul_grad/tuple/control_dependency_11gradients_1/loss_2/sub_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
В
#gradients_1/loss_2/sub_grad/ReshapeReshapegradients_1/loss_2/sub_grad/Sum!gradients_1/loss_2/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

е
!gradients_1/loss_2/sub_grad/Sum_1Sum6gradients_1/loss_2/mul_grad/tuple/control_dependency_13gradients_1/loss_2/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
l
gradients_1/loss_2/sub_grad/NegNeg!gradients_1/loss_2/sub_grad/Sum_1*
T0*
_output_shapes
:
Ж
%gradients_1/loss_2/sub_grad/Reshape_1Reshapegradients_1/loss_2/sub_grad/Neg#gradients_1/loss_2/sub_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


,gradients_1/loss_2/sub_grad/tuple/group_depsNoOp$^gradients_1/loss_2/sub_grad/Reshape&^gradients_1/loss_2/sub_grad/Reshape_1
ў
4gradients_1/loss_2/sub_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/sub_grad/Reshape-^gradients_1/loss_2/sub_grad/tuple/group_deps*6
_class,
*(loc:@gradients_1/loss_2/sub_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


6gradients_1/loss_2/sub_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/sub_grad/Reshape_1-^gradients_1/loss_2/sub_grad/tuple/group_deps*8
_class.
,*loc:@gradients_1/loss_2/sub_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

§
gradients_1/AddN_3AddN6gradients_1/loss_2/pow_1_grad/tuple/control_dependency4gradients_1/loss_2/sub_grad/tuple/control_dependency*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

Ѕ
'gradients_1/loss_2/pos_items_grad/ShapeConst*+
_class!
loc:@variables_1/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:

&gradients_1/loss_2/pos_items_grad/SizeSize placeholders_1/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients_1/loss_2/pos_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients_1/loss_2/pos_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/pos_items_grad/Size0gradients_1/loss_2/pos_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients_1/loss_2/pos_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients_1/loss_2/pos_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients_1/loss_2/pos_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ї
/gradients_1/loss_2/pos_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/pos_items_grad/Shape5gradients_1/loss_2/pos_items_grad/strided_slice/stack7gradients_1/loss_2/pos_items_grad/strided_slice/stack_17gradients_1/loss_2/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
o
-gradients_1/loss_2/pos_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients_1/loss_2/pos_items_grad/concatConcatV2,gradients_1/loss_2/pos_items_grad/ExpandDims/gradients_1/loss_2/pos_items_grad/strided_slice-gradients_1/loss_2/pos_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Л
)gradients_1/loss_2/pos_items_grad/ReshapeReshapegradients_1/AddN_3(gradients_1/loss_2/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Т
+gradients_1/loss_2/pos_items_grad/Reshape_1Reshape placeholders_1/sampled_pos_items,gradients_1/loss_2/pos_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
џ
gradients_1/AddN_4AddN6gradients_1/loss_2/pow_3_grad/tuple/control_dependency6gradients_1/loss_2/sub_grad/tuple/control_dependency_1*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

Ѕ
'gradients_1/loss_2/neg_items_grad/ShapeConst*+
_class!
loc:@variables_1/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:

&gradients_1/loss_2/neg_items_grad/SizeSize placeholders_1/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients_1/loss_2/neg_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients_1/loss_2/neg_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/neg_items_grad/Size0gradients_1/loss_2/neg_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients_1/loss_2/neg_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients_1/loss_2/neg_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients_1/loss_2/neg_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ї
/gradients_1/loss_2/neg_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/neg_items_grad/Shape5gradients_1/loss_2/neg_items_grad/strided_slice/stack7gradients_1/loss_2/neg_items_grad/strided_slice/stack_17gradients_1/loss_2/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
o
-gradients_1/loss_2/neg_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients_1/loss_2/neg_items_grad/concatConcatV2,gradients_1/loss_2/neg_items_grad/ExpandDims/gradients_1/loss_2/neg_items_grad/strided_slice-gradients_1/loss_2/neg_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Л
)gradients_1/loss_2/neg_items_grad/ReshapeReshapegradients_1/AddN_4(gradients_1/loss_2/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Т
+gradients_1/loss_2/neg_items_grad/Reshape_1Reshape placeholders_1/sampled_neg_items,gradients_1/loss_2/neg_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
[
gradients_1/concat_2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
с
gradients_1/concat_2ConcatV2)gradients_1/loss_2/pos_items_grad/Reshape)gradients_1/loss_2/neg_items_grad/Reshapegradients_1/concat_2/axis*
N*

Tidx0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
[
gradients_1/concat_3/axisConst*
value	B : *
dtype0*
_output_shapes
: 
и
gradients_1/concat_3ConcatV2+gradients_1/loss_2/pos_items_grad/Reshape_1+gradients_1/loss_2/neg_items_grad/Reshape_1gradients_1/concat_3/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
d
GradientDescent_1/learning_rateConst*
valueB
 *ЭЬЬ=*
dtype0*
_output_shapes
: 
ь
5GradientDescent_1/update_variables_1/user_factors/mulMul%gradients_1/loss_2/users_grad/ReshapeGradientDescent_1/learning_rate*+
_class!
loc:@variables_1/user_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
О
<GradientDescent_1/update_variables_1/user_factors/ScatterSub
ScatterSubvariables_1/user_factors'gradients_1/loss_2/users_grad/Reshape_15GradientDescent_1/update_variables_1/user_factors/mul*
Tindices0*
use_locking( *
T0*+
_class!
loc:@variables_1/user_factors*
_output_shapes
:	

л
5GradientDescent_1/update_variables_1/item_factors/mulMulgradients_1/concat_2GradientDescent_1/learning_rate*+
_class!
loc:@variables_1/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ћ
<GradientDescent_1/update_variables_1/item_factors/ScatterSub
ScatterSubvariables_1/item_factorsgradients_1/concat_35GradientDescent_1/update_variables_1/item_factors/mul*
Tindices0*
use_locking( *
T0*+
_class!
loc:@variables_1/item_factors*
_output_shapes
:	э

Ц
2GradientDescent_1/update_variables_1/item_bias/mulMulgradients_1/concatGradientDescent_1/learning_rate*(
_class
loc:@variables_1/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

9GradientDescent_1/update_variables_1/item_bias/ScatterSub
ScatterSubvariables_1/item_biasgradients_1/concat_12GradientDescent_1/update_variables_1/item_bias/mul*
Tindices0*
use_locking( *
T0*(
_class
loc:@variables_1/item_bias*
_output_shapes	
:э
г
GradientDescent_1NoOp=^GradientDescent_1/update_variables_1/user_factors/ScatterSub=^GradientDescent_1/update_variables_1/item_factors/ScatterSub:^GradientDescent_1/update_variables_1/item_bias/ScatterSub
R
loss_3/tagsConst*
valueB Bloss_3*
dtype0*
_output_shapes
: 
S
loss_3ScalarSummaryloss_3/tagsloss_2/sub_2*
T0*
_output_shapes
: 
U
Merge_1/MergeSummaryMergeSummaryloss_1loss_3*
N*
_output_shapes
: 
Ю
init_1NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign""2
train_op&
$
GradientDescent
GradientDescent_1"#
	summaries

loss_1:0
loss_3:0"­
	variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0
^
variables_1/user_factors:0variables_1/user_factors/Assignvariables_1/user_factors/read:0
^
variables_1/item_factors:0variables_1/item_factors/Assignvariables_1/item_factors/read:0
U
variables_1/item_bias:0variables_1/item_bias/Assignvariables_1/item_bias/read:0"З
trainable_variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0
^
variables_1/user_factors:0variables_1/user_factors/Assignvariables_1/user_factors/read:0
^
variables_1/item_factors:0variables_1/item_factors/Assignvariables_1/item_factors/read:0
U
variables_1/item_bias:0variables_1/item_bias/Assignvariables_1/item_bias/read:0ЭїПЬ