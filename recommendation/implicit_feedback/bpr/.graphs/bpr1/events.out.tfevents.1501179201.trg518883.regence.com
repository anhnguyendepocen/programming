       �K"	  @P�^�Abrain.Event:2	?�8     XZ�	(
)P�^�A"��
h
placeholders/sampled_usersPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
l
placeholders/sampled_pos_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
l
placeholders/sampled_neg_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
q
 variables/truncated_normal/shapeConst*
_output_shapes
:*
dtype0*
valueB"  
   
d
variables/truncated_normal/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
f
!variables/truncated_normal/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2�	*
seed���)*
_output_shapes
:	�
*
dtype0*
T0
�
variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	�
*
T0
�
variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	�
*
T0
s
"variables/truncated_normal_1/shapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   
f
!variables/truncated_normal_1/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
h
#variables/truncated_normal_1/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2�	*
seed���)*
_output_shapes
:	�
*
dtype0*
T0
�
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	�
*
T0
�
variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	�
*
T0
�
variables/user_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/user_factors*
_output_shapes
:	�

�
variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	�
*
T0*)
_class
loc:@variables/user_factors
�
variables/item_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/item_factors*
_output_shapes
:	�

�
variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	�
*
T0*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
_output_shapes	
:�*
dtype0*
valueB�*    
�
variables/item_bias
VariableV2*
_output_shapes	
:�*
dtype0*
shape:�*
shared_name *
	container 
�
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
validate_shape(*
T0*
use_locking(*&
_class
loc:@variables/item_bias*
_output_shapes	
:�
�
variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:�*
T0*&
_class
loc:@variables/item_bias
�

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
�
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:���������
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:���������
*
T0
\
loss/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :
�
loss/SumSumloss/mulloss/Sum/reduction_indices*#
_output_shapes
:���������*
	keep_dims( *

Tidx0*
T0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:���������*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:���������*
T0
G
loss/NegNegloss/add*#
_output_shapes
:���������*
T0
G
loss/ExpExploss/Neg*#
_output_shapes
:���������*
T0
Q
loss/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
W

loss/add_1Addloss/add_1/xloss/Exp*#
_output_shapes
:���������*
T0
I
loss/LogLog
loss/add_1*#
_output_shapes
:���������*
T0
I

loss/Neg_1Negloss/Log*#
_output_shapes
:���������*
T0
T

loss/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
O

loss/pow/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y
loss/powPow
loss/users
loss/pow/y*'
_output_shapes
:���������
*
T0
]
loss/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       
g

loss/Sum_2Sumloss/powloss/Const_1*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
_output_shapes
: *
T0
Q
loss/pow_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*'
_output_shapes
:���������
*
T0
]
loss/Const_2Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss/mul_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
_output_shapes
: *
T0
Q
loss/pow_2/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*#
_output_shapes
:���������*
T0
V
loss/Const_3Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
_output_shapes
: *
T0
Q
loss/pow_3/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*'
_output_shapes
:���������
*
T0
]
loss/Const_4Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss/mul_3/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
_output_shapes
: *
T0
Q
loss/pow_4/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*#
_output_shapes
:���������*
T0
V
loss/Const_5Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
_output_shapes
: *
T0
J

loss/add_4Add
loss/mul_1
loss/add_2*
_output_shapes
: *
T0
J

loss/add_5Add
loss/add_4
loss/add_3*
_output_shapes
: *
T0
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
_output_shapes
: *
T0
R
gradients/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
T
gradients/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
Y
gradients/FillFillgradients/Shapegradients/Const*
_output_shapes
: *
T0
b
gradients/loss/sub_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/sub_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
_output_shapes
:*
T0
�
#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
�
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
�
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1
b
gradients/loss/add_5_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_5_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
�
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape
�
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
b
gradients/loss/add_4_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
�
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
�
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1
b
gradients/loss/add_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
�
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
�
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*#
_output_shapes
:���������*
T0
b
gradients/loss/mul_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
�
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
�
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
�
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1
b
gradients/loss/add_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
�
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
�
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1
b
gradients/loss/mul_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
�
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
�
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
�
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
�
"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*#
_output_shapes
:���������*
T0
�
gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:���������*
T0
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

b
gradients/loss/mul_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
�
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
�
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
�
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:���������*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
h
#gradients/loss/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:���������*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:���������*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:���������*
T0
�
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
�
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
�
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1
b
gradients/loss/add_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
_output_shapes
:*
T0*
out_type0
�
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
�
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
�
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1
g
gradients/loss/pow_grad/ShapeShape
loss/users*
_output_shapes
:*
T0*
out_type0
b
gradients/loss/pow_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:���������
*
T0
b
gradients/loss/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
_output_shapes
: *
T0
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
f
!gradients/loss/pow_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:���������
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:���������
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
�
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
�
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:���������*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
h
#gradients/loss/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:���������*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:���������*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:���������*
T0
�
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
�
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
�
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:���������
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
h
#gradients/loss/pow_3_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:���������
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:���������
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:���������
*
T0
�
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
�
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
�
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1
�
gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*#
_output_shapes
:���������*
T0
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:���������
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
h
#gradients/loss/pow_1_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:���������
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:���������
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:���������
*
T0
�
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
�
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
�
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*#
_output_shapes
:���������*
T0
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
_output_shapes
:*
T0*
out_type0
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
_output_shapes
:*
T0*
out_type0
�
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
�
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
�
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
_output_shapes
:*
T0*
out_type0
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
_output_shapes
:*
T0*
out_type0
�
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
_output_shapes
:*
T0
�
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
�
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
�
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
_output_shapes
:*
T0*
out_type0
^
gradients/loss/Sum_grad/SizeConst*
_output_shapes
: *
dtype0*
value	B :
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
�
gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
b
gradients/loss/Sum_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
e
#gradients/loss/Sum_grad/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
e
#gradients/loss/Sum_grad/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
d
"gradients/loss/Sum_grad/Fill/valueConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
�
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:���������*
N*
T0
c
!gradients/loss/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:���������*
T0
�
 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
�
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
�
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*
T0*'
_output_shapes
:���������

�
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:���������*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0
�
'gradients/loss/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*&
_class
loc:@variables/item_bias

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
: *
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:���������*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0
�
'gradients/loss/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*&
_class
loc:@variables/item_bias

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
: *
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
g
gradients/loss/mul_grad/ShapeShape
loss/users*
_output_shapes
:*
T0*
out_type0
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
_output_shapes
:*
T0*
out_type0
�
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:���������
*
T0
�
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
�
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
�
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1
W
gradients/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
Y
gradients/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
�
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0
�
gradients/loss/users_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"  
   *)
_class
loc:@variables/user_factors
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
_output_shapes
: *
T0*
out_type0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
w
-gradients/loss/users_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
:*
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
g
%gradients/loss/users_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
_output_shapes
:*
T0*
out_type0
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
_output_shapes
:*
T0*
out_type0
�
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
_output_shapes
:*
T0
�
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
�
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
�
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
�
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0
�
#gradients/loss/pos_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *)
_class
loc:@variables/item_factors
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
:*
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
k
)gradients/loss/pos_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:���������
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0
�
#gradients/loss/neg_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *)
_class
loc:@variables/item_factors
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
:*
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
k
)gradients/loss/neg_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
Y
gradients/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*0
_output_shapes
:������������������*
N*

Tidx0*
T0
Y
gradients/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
b
GradientDescent/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *���=
�
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:������������������*
T0*)
_class
loc:@variables/user_factors
�
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/user_factors
�
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:������������������*
T0*)
_class
loc:@variables/item_factors
�
8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/item_factors
�
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:���������*
T0*&
_class
loc:@variables/item_bias
�
5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
_output_shapes	
:�*
T0*
Tindices0*
use_locking( *&
_class
loc:@variables/item_bias
�
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
_output_shapes
: *
dtype0*
valueB Bloss_1
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
_output_shapes
: *
T0
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign
j
placeholders_1/sampled_usersPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
n
 placeholders_1/sampled_pos_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
n
 placeholders_1/sampled_neg_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
s
"variables_1/truncated_normal/shapeConst*
_output_shapes
:*
dtype0*
valueB"  
   
f
!variables_1/truncated_normal/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
h
#variables_1/truncated_normal/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
,variables_1/truncated_normal/TruncatedNormalTruncatedNormal"variables_1/truncated_normal/shape*
seed2�	*
seed���)*
_output_shapes
:	�
*
dtype0*
T0
�
 variables_1/truncated_normal/mulMul,variables_1/truncated_normal/TruncatedNormal#variables_1/truncated_normal/stddev*
_output_shapes
:	�
*
T0
�
variables_1/truncated_normalAdd variables_1/truncated_normal/mul!variables_1/truncated_normal/mean*
_output_shapes
:	�
*
T0
u
$variables_1/truncated_normal_1/shapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   
h
#variables_1/truncated_normal_1/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
j
%variables_1/truncated_normal_1/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
.variables_1/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_1/truncated_normal_1/shape*
seed2�	*
seed���)*
_output_shapes
:	�
*
dtype0*
T0
�
"variables_1/truncated_normal_1/mulMul.variables_1/truncated_normal_1/TruncatedNormal%variables_1/truncated_normal_1/stddev*
_output_shapes
:	�
*
T0
�
variables_1/truncated_normal_1Add"variables_1/truncated_normal_1/mul#variables_1/truncated_normal_1/mean*
_output_shapes
:	�
*
T0
�
variables_1/user_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables_1/user_factors/AssignAssignvariables_1/user_factorsvariables_1/truncated_normal*
validate_shape(*
T0*
use_locking(*+
_class!
loc:@variables_1/user_factors*
_output_shapes
:	�

�
variables_1/user_factors/readIdentityvariables_1/user_factors*
_output_shapes
:	�
*
T0*+
_class!
loc:@variables_1/user_factors
�
variables_1/item_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables_1/item_factors/AssignAssignvariables_1/item_factorsvariables_1/truncated_normal_1*
validate_shape(*
T0*
use_locking(*+
_class!
loc:@variables_1/item_factors*
_output_shapes
:	�

�
variables_1/item_factors/readIdentityvariables_1/item_factors*
_output_shapes
:	�
*
T0*+
_class!
loc:@variables_1/item_factors
`
variables_1/zerosConst*
_output_shapes	
:�*
dtype0*
valueB�*    
�
variables_1/item_bias
VariableV2*
_output_shapes	
:�*
dtype0*
shape:�*
shared_name *
	container 
�
variables_1/item_bias/AssignAssignvariables_1/item_biasvariables_1/zeros*
validate_shape(*
T0*
use_locking(*(
_class
loc:@variables_1/item_bias*
_output_shapes	
:�
�
variables_1/item_bias/readIdentityvariables_1/item_bias*
_output_shapes	
:�*
T0*(
_class
loc:@variables_1/item_bias
�
loss_2/usersGathervariables_1/user_factors/readplaceholders_1/sampled_users*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/pos_itemsGathervariables_1/item_factors/read placeholders_1/sampled_pos_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/neg_itemsGathervariables_1/item_factors/read placeholders_1/sampled_neg_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/pos_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_pos_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/neg_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_neg_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
g

loss_2/subSubloss_2/pos_itemsloss_2/neg_items*'
_output_shapes
:���������
*
T0
]

loss_2/mulMulloss_2/users
loss_2/sub*'
_output_shapes
:���������
*
T0
^
loss_2/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :
�

loss_2/SumSum
loss_2/mulloss_2/Sum/reduction_indices*#
_output_shapes
:���������*
	keep_dims( *

Tidx0*
T0
m
loss_2/sub_1Subloss_2/pos_item_biasloss_2/neg_item_bias*#
_output_shapes
:���������*
T0
Y

loss_2/addAddloss_2/sub_1
loss_2/Sum*#
_output_shapes
:���������*
T0
K

loss_2/NegNeg
loss_2/add*#
_output_shapes
:���������*
T0
K

loss_2/ExpExp
loss_2/Neg*#
_output_shapes
:���������*
T0
S
loss_2/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
]
loss_2/add_1Addloss_2/add_1/x
loss_2/Exp*#
_output_shapes
:���������*
T0
M

loss_2/LogLogloss_2/add_1*#
_output_shapes
:���������*
T0
M
loss_2/Neg_1Neg
loss_2/Log*#
_output_shapes
:���������*
T0
V
loss_2/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
m
loss_2/Sum_1Sumloss_2/Neg_1loss_2/Const*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss_2/pow/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
_

loss_2/powPowloss_2/usersloss_2/pow/y*'
_output_shapes
:���������
*
T0
_
loss_2/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       
m
loss_2/Sum_2Sum
loss_2/powloss_2/Const_1*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
S
loss_2/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
R
loss_2/mul_1Mulloss_2/mul_1/xloss_2/Sum_2*
_output_shapes
: *
T0
S
loss_2/pow_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_1Powloss_2/pos_itemsloss_2/pow_1/y*'
_output_shapes
:���������
*
T0
_
loss_2/Const_2Const*
_output_shapes
:*
dtype0*
valueB"       
o
loss_2/Sum_3Sumloss_2/pow_1loss_2/Const_2*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
S
loss_2/mul_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
R
loss_2/mul_2Mulloss_2/mul_2/xloss_2/Sum_3*
_output_shapes
: *
T0
S
loss_2/pow_2/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_2Powloss_2/pos_item_biasloss_2/pow_2/y*#
_output_shapes
:���������*
T0
X
loss_2/Const_3Const*
_output_shapes
:*
dtype0*
valueB: 
o
loss_2/Sum_4Sumloss_2/pow_2loss_2/Const_3*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
P
loss_2/add_2Addloss_2/mul_2loss_2/Sum_4*
_output_shapes
: *
T0
S
loss_2/pow_3/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_3Powloss_2/neg_itemsloss_2/pow_3/y*'
_output_shapes
:���������
*
T0
_
loss_2/Const_4Const*
_output_shapes
:*
dtype0*
valueB"       
o
loss_2/Sum_5Sumloss_2/pow_3loss_2/Const_4*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
S
loss_2/mul_3/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
R
loss_2/mul_3Mulloss_2/mul_3/xloss_2/Sum_5*
_output_shapes
: *
T0
S
loss_2/pow_4/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_4Powloss_2/neg_item_biasloss_2/pow_4/y*#
_output_shapes
:���������*
T0
X
loss_2/Const_5Const*
_output_shapes
:*
dtype0*
valueB: 
o
loss_2/Sum_6Sumloss_2/pow_4loss_2/Const_5*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
P
loss_2/add_3Addloss_2/mul_3loss_2/Sum_6*
_output_shapes
: *
T0
P
loss_2/add_4Addloss_2/mul_1loss_2/add_2*
_output_shapes
: *
T0
P
loss_2/add_5Addloss_2/add_4loss_2/add_3*
_output_shapes
: *
T0
P
loss_2/sub_2Subloss_2/add_5loss_2/Sum_1*
_output_shapes
: *
T0
T
gradients_1/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
V
gradients_1/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
_
gradients_1/FillFillgradients_1/Shapegradients_1/Const*
_output_shapes
: *
T0
f
#gradients_1/loss_2/sub_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/sub_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_2_grad/Shape%gradients_1/loss_2/sub_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/sub_2_grad/SumSumgradients_1/Fill3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/sub_2_grad/ReshapeReshape!gradients_1/loss_2/sub_2_grad/Sum#gradients_1/loss_2/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/sub_2_grad/Sum_1Sumgradients_1/Fill5gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
p
!gradients_1/loss_2/sub_2_grad/NegNeg#gradients_1/loss_2/sub_2_grad/Sum_1*
_output_shapes
:*
T0
�
'gradients_1/loss_2/sub_2_grad/Reshape_1Reshape!gradients_1/loss_2/sub_2_grad/Neg%gradients_1/loss_2/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/sub_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_2_grad/Reshape(^gradients_1/loss_2/sub_2_grad/Reshape_1
�
6gradients_1/loss_2/sub_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_2_grad/Reshape/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_2_grad/Reshape
�
8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_2_grad/Reshape_1/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/sub_2_grad/Reshape_1
f
#gradients_1/loss_2/add_5_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_5_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_5_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_5_grad/Shape%gradients_1/loss_2/add_5_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_5_grad/SumSum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency3gradients_1/loss_2/add_5_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_5_grad/ReshapeReshape!gradients_1/loss_2/add_5_grad/Sum#gradients_1/loss_2/add_5_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_5_grad/Sum_1Sum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency5gradients_1/loss_2/add_5_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_5_grad/Reshape_1Reshape#gradients_1/loss_2/add_5_grad/Sum_1%gradients_1/loss_2/add_5_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_5_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_5_grad/Reshape(^gradients_1/loss_2/add_5_grad/Reshape_1
�
6gradients_1/loss_2/add_5_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_5_grad/Reshape/^gradients_1/loss_2/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_5_grad/Reshape
�
8gradients_1/loss_2/add_5_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_5_grad/Reshape_1/^gradients_1/loss_2/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_5_grad/Reshape_1
u
+gradients_1/loss_2/Sum_1_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
%gradients_1/loss_2/Sum_1_grad/ReshapeReshape8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_1_grad/ShapeShapeloss_2/Neg_1*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_1_grad/TileTile%gradients_1/loss_2/Sum_1_grad/Reshape#gradients_1/loss_2/Sum_1_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
f
#gradients_1/loss_2/add_4_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_4_grad/Shape%gradients_1/loss_2/add_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_4_grad/SumSum6gradients_1/loss_2/add_5_grad/tuple/control_dependency3gradients_1/loss_2/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_4_grad/ReshapeReshape!gradients_1/loss_2/add_4_grad/Sum#gradients_1/loss_2/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_4_grad/Sum_1Sum6gradients_1/loss_2/add_5_grad/tuple/control_dependency5gradients_1/loss_2/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_4_grad/Reshape_1Reshape#gradients_1/loss_2/add_4_grad/Sum_1%gradients_1/loss_2/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_4_grad/Reshape(^gradients_1/loss_2/add_4_grad/Reshape_1
�
6gradients_1/loss_2/add_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_4_grad/Reshape/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_4_grad/Reshape
�
8gradients_1/loss_2/add_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_4_grad/Reshape_1/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_4_grad/Reshape_1
f
#gradients_1/loss_2/add_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_3_grad/Shape%gradients_1/loss_2/add_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_3_grad/SumSum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_13gradients_1/loss_2/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_3_grad/ReshapeReshape!gradients_1/loss_2/add_3_grad/Sum#gradients_1/loss_2/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_3_grad/Sum_1Sum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_15gradients_1/loss_2/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_3_grad/Reshape_1Reshape#gradients_1/loss_2/add_3_grad/Sum_1%gradients_1/loss_2/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_3_grad/Reshape(^gradients_1/loss_2/add_3_grad/Reshape_1
�
6gradients_1/loss_2/add_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_3_grad/Reshape/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_3_grad/Reshape
�
8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_3_grad/Reshape_1/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_3_grad/Reshape_1
z
!gradients_1/loss_2/Neg_1_grad/NegNeg"gradients_1/loss_2/Sum_1_grad/Tile*#
_output_shapes
:���������*
T0
f
#gradients_1/loss_2/mul_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/mul_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_1_grad/Shape%gradients_1/loss_2/mul_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/mul_1_grad/mulMul6gradients_1/loss_2/add_4_grad/tuple/control_dependencyloss_2/Sum_2*
_output_shapes
: *
T0
�
!gradients_1/loss_2/mul_1_grad/SumSum!gradients_1/loss_2/mul_1_grad/mul3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_1_grad/ReshapeReshape!gradients_1/loss_2/mul_1_grad/Sum#gradients_1/loss_2/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/mul_1_grad/mul_1Mulloss_2/mul_1/x6gradients_1/loss_2/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
#gradients_1/loss_2/mul_1_grad/Sum_1Sum#gradients_1/loss_2/mul_1_grad/mul_15gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/mul_1_grad/Reshape_1Reshape#gradients_1/loss_2/mul_1_grad/Sum_1%gradients_1/loss_2/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/mul_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_1_grad/Reshape(^gradients_1/loss_2/mul_1_grad/Reshape_1
�
6gradients_1/loss_2/mul_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_1_grad/Reshape/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_1_grad/Reshape
�
8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_1_grad/Reshape_1/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_1_grad/Reshape_1
f
#gradients_1/loss_2/add_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_2_grad/Shape%gradients_1/loss_2/add_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_2_grad/SumSum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_13gradients_1/loss_2/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_2_grad/ReshapeReshape!gradients_1/loss_2/add_2_grad/Sum#gradients_1/loss_2/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_2_grad/Sum_1Sum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_15gradients_1/loss_2/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_2_grad/Reshape_1Reshape#gradients_1/loss_2/add_2_grad/Sum_1%gradients_1/loss_2/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_2_grad/Reshape(^gradients_1/loss_2/add_2_grad/Reshape_1
�
6gradients_1/loss_2/add_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_2_grad/Reshape/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_2_grad/Reshape
�
8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_2_grad/Reshape_1/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_2_grad/Reshape_1
f
#gradients_1/loss_2/mul_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/mul_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_3_grad/Shape%gradients_1/loss_2/mul_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/mul_3_grad/mulMul6gradients_1/loss_2/add_3_grad/tuple/control_dependencyloss_2/Sum_5*
_output_shapes
: *
T0
�
!gradients_1/loss_2/mul_3_grad/SumSum!gradients_1/loss_2/mul_3_grad/mul3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_3_grad/ReshapeReshape!gradients_1/loss_2/mul_3_grad/Sum#gradients_1/loss_2/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/mul_3_grad/mul_1Mulloss_2/mul_3/x6gradients_1/loss_2/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
#gradients_1/loss_2/mul_3_grad/Sum_1Sum#gradients_1/loss_2/mul_3_grad/mul_15gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/mul_3_grad/Reshape_1Reshape#gradients_1/loss_2/mul_3_grad/Sum_1%gradients_1/loss_2/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/mul_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_3_grad/Reshape(^gradients_1/loss_2/mul_3_grad/Reshape_1
�
6gradients_1/loss_2/mul_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_3_grad/Reshape/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_3_grad/Reshape
�
8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_3_grad/Reshape_1/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_3_grad/Reshape_1
u
+gradients_1/loss_2/Sum_6_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
%gradients_1/loss_2/Sum_6_grad/ReshapeReshape8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_6_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_6_grad/ShapeShapeloss_2/pow_4*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_6_grad/TileTile%gradients_1/loss_2/Sum_6_grad/Reshape#gradients_1/loss_2/Sum_6_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
�
&gradients_1/loss_2/Log_grad/Reciprocal
Reciprocalloss_2/add_1"^gradients_1/loss_2/Neg_1_grad/Neg*#
_output_shapes
:���������*
T0
�
gradients_1/loss_2/Log_grad/mulMul!gradients_1/loss_2/Neg_1_grad/Neg&gradients_1/loss_2/Log_grad/Reciprocal*#
_output_shapes
:���������*
T0
|
+gradients_1/loss_2/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
%gradients_1/loss_2/Sum_2_grad/ReshapeReshape8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_2_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
m
#gradients_1/loss_2/Sum_2_grad/ShapeShape
loss_2/pow*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_2_grad/TileTile%gradients_1/loss_2/Sum_2_grad/Reshape#gradients_1/loss_2/Sum_2_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

f
#gradients_1/loss_2/mul_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/mul_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_2_grad/Shape%gradients_1/loss_2/mul_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/mul_2_grad/mulMul6gradients_1/loss_2/add_2_grad/tuple/control_dependencyloss_2/Sum_3*
_output_shapes
: *
T0
�
!gradients_1/loss_2/mul_2_grad/SumSum!gradients_1/loss_2/mul_2_grad/mul3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_2_grad/ReshapeReshape!gradients_1/loss_2/mul_2_grad/Sum#gradients_1/loss_2/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/mul_2_grad/mul_1Mulloss_2/mul_2/x6gradients_1/loss_2/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
#gradients_1/loss_2/mul_2_grad/Sum_1Sum#gradients_1/loss_2/mul_2_grad/mul_15gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/mul_2_grad/Reshape_1Reshape#gradients_1/loss_2/mul_2_grad/Sum_1%gradients_1/loss_2/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/mul_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_2_grad/Reshape(^gradients_1/loss_2/mul_2_grad/Reshape_1
�
6gradients_1/loss_2/mul_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_2_grad/Reshape/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_2_grad/Reshape
�
8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_2_grad/Reshape_1/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_2_grad/Reshape_1
u
+gradients_1/loss_2/Sum_4_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
%gradients_1/loss_2/Sum_4_grad/ReshapeReshape8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_4_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_4_grad/ShapeShapeloss_2/pow_2*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_4_grad/TileTile%gradients_1/loss_2/Sum_4_grad/Reshape#gradients_1/loss_2/Sum_4_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
|
+gradients_1/loss_2/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
%gradients_1/loss_2/Sum_5_grad/ReshapeReshape8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_5_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_5_grad/ShapeShapeloss_2/pow_3*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_5_grad/TileTile%gradients_1/loss_2/Sum_5_grad/Reshape#gradients_1/loss_2/Sum_5_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

w
#gradients_1/loss_2/pow_4_grad/ShapeShapeloss_2/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_4_grad/Shape%gradients_1/loss_2/pow_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_4_grad/mulMul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4/y*#
_output_shapes
:���������*
T0
h
#gradients_1/loss_2/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_4_grad/subSubloss_2/pow_4/y#gradients_1/loss_2/pow_4_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_4_grad/PowPowloss_2/neg_item_bias!gradients_1/loss_2/pow_4_grad/sub*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/mul_1Mul!gradients_1/loss_2/pow_4_grad/mul!gradients_1/loss_2/pow_4_grad/Pow*#
_output_shapes
:���������*
T0
�
!gradients_1/loss_2/pow_4_grad/SumSum#gradients_1/loss_2/pow_4_grad/mul_13gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_4_grad/ReshapeReshape!gradients_1/loss_2/pow_4_grad/Sum#gradients_1/loss_2/pow_4_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
l
'gradients_1/loss_2/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_4_grad/GreaterGreaterloss_2/neg_item_bias'gradients_1/loss_2/pow_4_grad/Greater/y*#
_output_shapes
:���������*
T0
l
!gradients_1/loss_2/pow_4_grad/LogLogloss_2/neg_item_bias*#
_output_shapes
:���������*
T0
y
(gradients_1/loss_2/pow_4_grad/zeros_like	ZerosLikeloss_2/neg_item_bias*#
_output_shapes
:���������*
T0
�
$gradients_1/loss_2/pow_4_grad/SelectSelect%gradients_1/loss_2/pow_4_grad/Greater!gradients_1/loss_2/pow_4_grad/Log(gradients_1/loss_2/pow_4_grad/zeros_like*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/mul_2Mul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/mul_3Mul#gradients_1/loss_2/pow_4_grad/mul_2$gradients_1/loss_2/pow_4_grad/Select*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/Sum_1Sum#gradients_1/loss_2/pow_4_grad/mul_35gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_4_grad/Reshape_1Reshape#gradients_1/loss_2/pow_4_grad/Sum_1%gradients_1/loss_2/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_4_grad/Reshape(^gradients_1/loss_2/pow_4_grad/Reshape_1
�
6gradients_1/loss_2/pow_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_4_grad/Reshape/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape
�
8gradients_1/loss_2/pow_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_4_grad/Reshape_1/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_4_grad/Reshape_1
f
#gradients_1/loss_2/add_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
o
%gradients_1/loss_2/add_1_grad/Shape_1Shape
loss_2/Exp*
_output_shapes
:*
T0*
out_type0
�
3gradients_1/loss_2/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_1_grad/Shape%gradients_1/loss_2/add_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_1_grad/SumSumgradients_1/loss_2/Log_grad/mul3gradients_1/loss_2/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_1_grad/ReshapeReshape!gradients_1/loss_2/add_1_grad/Sum#gradients_1/loss_2/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_1_grad/Sum_1Sumgradients_1/loss_2/Log_grad/mul5gradients_1/loss_2/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_1_grad/Reshape_1Reshape#gradients_1/loss_2/add_1_grad/Sum_1%gradients_1/loss_2/add_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
�
.gradients_1/loss_2/add_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_1_grad/Reshape(^gradients_1/loss_2/add_1_grad/Reshape_1
�
6gradients_1/loss_2/add_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_1_grad/Reshape/^gradients_1/loss_2/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_1_grad/Reshape
�
8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_1_grad/Reshape_1/^gradients_1/loss_2/add_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*:
_class0
.,loc:@gradients_1/loss_2/add_1_grad/Reshape_1
m
!gradients_1/loss_2/pow_grad/ShapeShapeloss_2/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_1/loss_2/pow_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
1gradients_1/loss_2/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/pow_grad/Shape#gradients_1/loss_2/pow_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/pow_grad/mulMul"gradients_1/loss_2/Sum_2_grad/Tileloss_2/pow/y*'
_output_shapes
:���������
*
T0
f
!gradients_1/loss_2/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
x
gradients_1/loss_2/pow_grad/subSubloss_2/pow/y!gradients_1/loss_2/pow_grad/sub/y*
_output_shapes
: *
T0
�
gradients_1/loss_2/pow_grad/PowPowloss_2/usersgradients_1/loss_2/pow_grad/sub*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/mul_1Mulgradients_1/loss_2/pow_grad/mulgradients_1/loss_2/pow_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients_1/loss_2/pow_grad/SumSum!gradients_1/loss_2/pow_grad/mul_11gradients_1/loss_2/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/pow_grad/ReshapeReshapegradients_1/loss_2/pow_grad/Sum!gradients_1/loss_2/pow_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
j
%gradients_1/loss_2/pow_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
#gradients_1/loss_2/pow_grad/GreaterGreaterloss_2/users%gradients_1/loss_2/pow_grad/Greater/y*'
_output_shapes
:���������
*
T0
f
gradients_1/loss_2/pow_grad/LogLogloss_2/users*'
_output_shapes
:���������
*
T0
s
&gradients_1/loss_2/pow_grad/zeros_like	ZerosLikeloss_2/users*'
_output_shapes
:���������
*
T0
�
"gradients_1/loss_2/pow_grad/SelectSelect#gradients_1/loss_2/pow_grad/Greatergradients_1/loss_2/pow_grad/Log&gradients_1/loss_2/pow_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/mul_2Mul"gradients_1/loss_2/Sum_2_grad/Tile
loss_2/pow*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/mul_3Mul!gradients_1/loss_2/pow_grad/mul_2"gradients_1/loss_2/pow_grad/Select*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/Sum_1Sum!gradients_1/loss_2/pow_grad/mul_33gradients_1/loss_2/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_grad/Reshape_1Reshape!gradients_1/loss_2/pow_grad/Sum_1#gradients_1/loss_2/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
,gradients_1/loss_2/pow_grad/tuple/group_depsNoOp$^gradients_1/loss_2/pow_grad/Reshape&^gradients_1/loss_2/pow_grad/Reshape_1
�
4gradients_1/loss_2/pow_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/pow_grad/Reshape-^gradients_1/loss_2/pow_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape
�
6gradients_1/loss_2/pow_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/pow_grad/Reshape_1-^gradients_1/loss_2/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_grad/Reshape_1
|
+gradients_1/loss_2/Sum_3_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
%gradients_1/loss_2/Sum_3_grad/ReshapeReshape8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_3_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_3_grad/ShapeShapeloss_2/pow_1*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_3_grad/TileTile%gradients_1/loss_2/Sum_3_grad/Reshape#gradients_1/loss_2/Sum_3_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

w
#gradients_1/loss_2/pow_2_grad/ShapeShapeloss_2/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_2_grad/Shape%gradients_1/loss_2/pow_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_2_grad/mulMul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2/y*#
_output_shapes
:���������*
T0
h
#gradients_1/loss_2/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_2_grad/subSubloss_2/pow_2/y#gradients_1/loss_2/pow_2_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_2_grad/PowPowloss_2/pos_item_bias!gradients_1/loss_2/pow_2_grad/sub*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/mul_1Mul!gradients_1/loss_2/pow_2_grad/mul!gradients_1/loss_2/pow_2_grad/Pow*#
_output_shapes
:���������*
T0
�
!gradients_1/loss_2/pow_2_grad/SumSum#gradients_1/loss_2/pow_2_grad/mul_13gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_2_grad/ReshapeReshape!gradients_1/loss_2/pow_2_grad/Sum#gradients_1/loss_2/pow_2_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
l
'gradients_1/loss_2/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_2_grad/GreaterGreaterloss_2/pos_item_bias'gradients_1/loss_2/pow_2_grad/Greater/y*#
_output_shapes
:���������*
T0
l
!gradients_1/loss_2/pow_2_grad/LogLogloss_2/pos_item_bias*#
_output_shapes
:���������*
T0
y
(gradients_1/loss_2/pow_2_grad/zeros_like	ZerosLikeloss_2/pos_item_bias*#
_output_shapes
:���������*
T0
�
$gradients_1/loss_2/pow_2_grad/SelectSelect%gradients_1/loss_2/pow_2_grad/Greater!gradients_1/loss_2/pow_2_grad/Log(gradients_1/loss_2/pow_2_grad/zeros_like*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/mul_2Mul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/mul_3Mul#gradients_1/loss_2/pow_2_grad/mul_2$gradients_1/loss_2/pow_2_grad/Select*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/Sum_1Sum#gradients_1/loss_2/pow_2_grad/mul_35gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_2_grad/Reshape_1Reshape#gradients_1/loss_2/pow_2_grad/Sum_1%gradients_1/loss_2/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_2_grad/Reshape(^gradients_1/loss_2/pow_2_grad/Reshape_1
�
6gradients_1/loss_2/pow_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_2_grad/Reshape/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape
�
8gradients_1/loss_2/pow_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_2_grad/Reshape_1/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_2_grad/Reshape_1
s
#gradients_1/loss_2/pow_3_grad/ShapeShapeloss_2/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_3_grad/Shape%gradients_1/loss_2/pow_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_3_grad/mulMul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3/y*'
_output_shapes
:���������
*
T0
h
#gradients_1/loss_2/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_3_grad/subSubloss_2/pow_3/y#gradients_1/loss_2/pow_3_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_3_grad/PowPowloss_2/neg_items!gradients_1/loss_2/pow_3_grad/sub*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/mul_1Mul!gradients_1/loss_2/pow_3_grad/mul!gradients_1/loss_2/pow_3_grad/Pow*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_3_grad/SumSum#gradients_1/loss_2/pow_3_grad/mul_13gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_3_grad/ReshapeReshape!gradients_1/loss_2/pow_3_grad/Sum#gradients_1/loss_2/pow_3_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
l
'gradients_1/loss_2/pow_3_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_3_grad/GreaterGreaterloss_2/neg_items'gradients_1/loss_2/pow_3_grad/Greater/y*'
_output_shapes
:���������
*
T0
l
!gradients_1/loss_2/pow_3_grad/LogLogloss_2/neg_items*'
_output_shapes
:���������
*
T0
y
(gradients_1/loss_2/pow_3_grad/zeros_like	ZerosLikeloss_2/neg_items*'
_output_shapes
:���������
*
T0
�
$gradients_1/loss_2/pow_3_grad/SelectSelect%gradients_1/loss_2/pow_3_grad/Greater!gradients_1/loss_2/pow_3_grad/Log(gradients_1/loss_2/pow_3_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/mul_2Mul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/mul_3Mul#gradients_1/loss_2/pow_3_grad/mul_2$gradients_1/loss_2/pow_3_grad/Select*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/Sum_1Sum#gradients_1/loss_2/pow_3_grad/mul_35gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_3_grad/Reshape_1Reshape#gradients_1/loss_2/pow_3_grad/Sum_1%gradients_1/loss_2/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_3_grad/Reshape(^gradients_1/loss_2/pow_3_grad/Reshape_1
�
6gradients_1/loss_2/pow_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_3_grad/Reshape/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape
�
8gradients_1/loss_2/pow_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_3_grad/Reshape_1/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_3_grad/Reshape_1
�
gradients_1/loss_2/Exp_grad/mulMul8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1
loss_2/Exp*#
_output_shapes
:���������*
T0
s
#gradients_1/loss_2/pow_1_grad/ShapeShapeloss_2/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_1_grad/Shape%gradients_1/loss_2/pow_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_1_grad/mulMul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1/y*'
_output_shapes
:���������
*
T0
h
#gradients_1/loss_2/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_1_grad/subSubloss_2/pow_1/y#gradients_1/loss_2/pow_1_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_1_grad/PowPowloss_2/pos_items!gradients_1/loss_2/pow_1_grad/sub*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/mul_1Mul!gradients_1/loss_2/pow_1_grad/mul!gradients_1/loss_2/pow_1_grad/Pow*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_1_grad/SumSum#gradients_1/loss_2/pow_1_grad/mul_13gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_1_grad/ReshapeReshape!gradients_1/loss_2/pow_1_grad/Sum#gradients_1/loss_2/pow_1_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
l
'gradients_1/loss_2/pow_1_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_1_grad/GreaterGreaterloss_2/pos_items'gradients_1/loss_2/pow_1_grad/Greater/y*'
_output_shapes
:���������
*
T0
l
!gradients_1/loss_2/pow_1_grad/LogLogloss_2/pos_items*'
_output_shapes
:���������
*
T0
y
(gradients_1/loss_2/pow_1_grad/zeros_like	ZerosLikeloss_2/pos_items*'
_output_shapes
:���������
*
T0
�
$gradients_1/loss_2/pow_1_grad/SelectSelect%gradients_1/loss_2/pow_1_grad/Greater!gradients_1/loss_2/pow_1_grad/Log(gradients_1/loss_2/pow_1_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/mul_2Mul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/mul_3Mul#gradients_1/loss_2/pow_1_grad/mul_2$gradients_1/loss_2/pow_1_grad/Select*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/Sum_1Sum#gradients_1/loss_2/pow_1_grad/mul_35gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_1_grad/Reshape_1Reshape#gradients_1/loss_2/pow_1_grad/Sum_1%gradients_1/loss_2/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_1_grad/Reshape(^gradients_1/loss_2/pow_1_grad/Reshape_1
�
6gradients_1/loss_2/pow_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_1_grad/Reshape/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape
�
8gradients_1/loss_2/pow_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_1_grad/Reshape_1/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_1_grad/Reshape_1
u
gradients_1/loss_2/Neg_grad/NegNeggradients_1/loss_2/Exp_grad/mul*#
_output_shapes
:���������*
T0
m
!gradients_1/loss_2/add_grad/ShapeShapeloss_2/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_1/loss_2/add_grad/Shape_1Shape
loss_2/Sum*
_output_shapes
:*
T0*
out_type0
�
1gradients_1/loss_2/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/add_grad/Shape#gradients_1/loss_2/add_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/add_grad/SumSumgradients_1/loss_2/Neg_grad/Neg1gradients_1/loss_2/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/add_grad/ReshapeReshapegradients_1/loss_2/add_grad/Sum!gradients_1/loss_2/add_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
!gradients_1/loss_2/add_grad/Sum_1Sumgradients_1/loss_2/Neg_grad/Neg3gradients_1/loss_2/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_grad/Reshape_1Reshape!gradients_1/loss_2/add_grad/Sum_1#gradients_1/loss_2/add_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
�
,gradients_1/loss_2/add_grad/tuple/group_depsNoOp$^gradients_1/loss_2/add_grad/Reshape&^gradients_1/loss_2/add_grad/Reshape_1
�
4gradients_1/loss_2/add_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/add_grad/Reshape-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*6
_class,
*(loc:@gradients_1/loss_2/add_grad/Reshape
�
6gradients_1/loss_2/add_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/add_grad/Reshape_1-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/add_grad/Reshape_1
w
#gradients_1/loss_2/sub_1_grad/ShapeShapeloss_2/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_1/loss_2/sub_1_grad/Shape_1Shapeloss_2/neg_item_bias*
_output_shapes
:*
T0*
out_type0
�
3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_1_grad/Shape%gradients_1/loss_2/sub_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/sub_1_grad/SumSum4gradients_1/loss_2/add_grad/tuple/control_dependency3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/sub_1_grad/ReshapeReshape!gradients_1/loss_2/sub_1_grad/Sum#gradients_1/loss_2/sub_1_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
#gradients_1/loss_2/sub_1_grad/Sum_1Sum4gradients_1/loss_2/add_grad/tuple/control_dependency5gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
p
!gradients_1/loss_2/sub_1_grad/NegNeg#gradients_1/loss_2/sub_1_grad/Sum_1*
_output_shapes
:*
T0
�
'gradients_1/loss_2/sub_1_grad/Reshape_1Reshape!gradients_1/loss_2/sub_1_grad/Neg%gradients_1/loss_2/sub_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
�
.gradients_1/loss_2/sub_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_1_grad/Reshape(^gradients_1/loss_2/sub_1_grad/Reshape_1
�
6gradients_1/loss_2/sub_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_1_grad/Reshape/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_1_grad/Reshape
�
8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_1_grad/Reshape_1/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*:
_class0
.,loc:@gradients_1/loss_2/sub_1_grad/Reshape_1
k
!gradients_1/loss_2/Sum_grad/ShapeShape
loss_2/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_1/loss_2/Sum_grad/SizeConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients_1/loss_2/Sum_grad/addAddloss_2/Sum/reduction_indices gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
�
gradients_1/loss_2/Sum_grad/modFloorModgradients_1/loss_2/Sum_grad/add gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_1/loss_2/Sum_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
i
'gradients_1/loss_2/Sum_grad/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
i
'gradients_1/loss_2/Sum_grad/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
�
!gradients_1/loss_2/Sum_grad/rangeRange'gradients_1/loss_2/Sum_grad/range/start gradients_1/loss_2/Sum_grad/Size'gradients_1/loss_2/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_1/loss_2/Sum_grad/Fill/valueConst*
_output_shapes
: *
dtype0*
value	B :
�
 gradients_1/loss_2/Sum_grad/FillFill#gradients_1/loss_2/Sum_grad/Shape_1&gradients_1/loss_2/Sum_grad/Fill/value*
_output_shapes
: *
T0
�
)gradients_1/loss_2/Sum_grad/DynamicStitchDynamicStitch!gradients_1/loss_2/Sum_grad/rangegradients_1/loss_2/Sum_grad/mod!gradients_1/loss_2/Sum_grad/Shape gradients_1/loss_2/Sum_grad/Fill*#
_output_shapes
:���������*
N*
T0
g
%gradients_1/loss_2/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
�
#gradients_1/loss_2/Sum_grad/MaximumMaximum)gradients_1/loss_2/Sum_grad/DynamicStitch%gradients_1/loss_2/Sum_grad/Maximum/y*#
_output_shapes
:���������*
T0
�
$gradients_1/loss_2/Sum_grad/floordivFloorDiv!gradients_1/loss_2/Sum_grad/Shape#gradients_1/loss_2/Sum_grad/Maximum*
_output_shapes
:*
T0
�
#gradients_1/loss_2/Sum_grad/ReshapeReshape6gradients_1/loss_2/add_grad/tuple/control_dependency_1)gradients_1/loss_2/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
�
 gradients_1/loss_2/Sum_grad/TileTile#gradients_1/loss_2/Sum_grad/Reshape$gradients_1/loss_2/Sum_grad/floordiv*

Tmultiples0*
T0*'
_output_shapes
:���������

�
gradients_1/AddNAddN6gradients_1/loss_2/pow_2_grad/tuple/control_dependency6gradients_1/loss_2/sub_1_grad/tuple/control_dependency*#
_output_shapes
:���������*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape*
T0
�
+gradients_1/loss_2/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*(
_class
loc:@variables_1/item_bias
�
*gradients_1/loss_2/pos_item_bias_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
0gradients_1/loss_2/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/pos_item_bias_grad/Size4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
�
9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
3gradients_1/loss_2/pos_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/pos_item_bias_grad/Shape9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
: *
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
s
1gradients_1/loss_2/pos_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/pos_item_bias_grad/concatConcatV20gradients_1/loss_2/pos_item_bias_grad/ExpandDims3gradients_1/loss_2/pos_item_bias_grad/strided_slice1gradients_1/loss_2/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
-gradients_1/loss_2/pos_item_bias_grad/ReshapeReshapegradients_1/AddN,gradients_1/loss_2/pos_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
/gradients_1/loss_2/pos_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_pos_items0gradients_1/loss_2/pos_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients_1/AddN_1AddN6gradients_1/loss_2/pow_4_grad/tuple/control_dependency8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:���������*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape*
T0
�
+gradients_1/loss_2/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*(
_class
loc:@variables_1/item_bias
�
*gradients_1/loss_2/neg_item_bias_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
0gradients_1/loss_2/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/neg_item_bias_grad/Size4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
�
9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
3gradients_1/loss_2/neg_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/neg_item_bias_grad/Shape9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
: *
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
s
1gradients_1/loss_2/neg_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/neg_item_bias_grad/concatConcatV20gradients_1/loss_2/neg_item_bias_grad/ExpandDims3gradients_1/loss_2/neg_item_bias_grad/strided_slice1gradients_1/loss_2/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
-gradients_1/loss_2/neg_item_bias_grad/ReshapeReshapegradients_1/AddN_1,gradients_1/loss_2/neg_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
/gradients_1/loss_2/neg_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_neg_items0gradients_1/loss_2/neg_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
m
!gradients_1/loss_2/mul_grad/ShapeShapeloss_2/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_1/loss_2/mul_grad/Shape_1Shape
loss_2/sub*
_output_shapes
:*
T0*
out_type0
�
1gradients_1/loss_2/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/mul_grad/Shape#gradients_1/loss_2/mul_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/mul_grad/mulMul gradients_1/loss_2/Sum_grad/Tile
loss_2/sub*'
_output_shapes
:���������
*
T0
�
gradients_1/loss_2/mul_grad/SumSumgradients_1/loss_2/mul_grad/mul1gradients_1/loss_2/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/mul_grad/ReshapeReshapegradients_1/loss_2/mul_grad/Sum!gradients_1/loss_2/mul_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
!gradients_1/loss_2/mul_grad/mul_1Mulloss_2/users gradients_1/loss_2/Sum_grad/Tile*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/mul_grad/Sum_1Sum!gradients_1/loss_2/mul_grad/mul_13gradients_1/loss_2/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_grad/Reshape_1Reshape!gradients_1/loss_2/mul_grad/Sum_1#gradients_1/loss_2/mul_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
�
,gradients_1/loss_2/mul_grad/tuple/group_depsNoOp$^gradients_1/loss_2/mul_grad/Reshape&^gradients_1/loss_2/mul_grad/Reshape_1
�
4gradients_1/loss_2/mul_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/mul_grad/Reshape-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*6
_class,
*(loc:@gradients_1/loss_2/mul_grad/Reshape
�
6gradients_1/loss_2/mul_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/mul_grad/Reshape_1-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_grad/Reshape_1
Y
gradients_1/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concatConcatV2-gradients_1/loss_2/pos_item_bias_grad/Reshape-gradients_1/loss_2/neg_item_bias_grad/Reshapegradients_1/concat/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
[
gradients_1/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concat_1ConcatV2/gradients_1/loss_2/pos_item_bias_grad/Reshape_1/gradients_1/loss_2/neg_item_bias_grad/Reshape_1gradients_1/concat_1/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
�
gradients_1/AddN_2AddN4gradients_1/loss_2/pow_grad/tuple/control_dependency4gradients_1/loss_2/mul_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape*
T0
�
#gradients_1/loss_2/users_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"  
   *+
_class!
loc:@variables_1/user_factors
y
"gradients_1/loss_2/users_grad/SizeSizeplaceholders_1/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_1/loss_2/users_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients_1/loss_2/users_grad/ExpandDims
ExpandDims"gradients_1/loss_2/users_grad/Size,gradients_1/loss_2/users_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
{
1gradients_1/loss_2/users_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients_1/loss_2/users_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients_1/loss_2/users_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients_1/loss_2/users_grad/strided_sliceStridedSlice#gradients_1/loss_2/users_grad/Shape1gradients_1/loss_2/users_grad/strided_slice/stack3gradients_1/loss_2/users_grad/strided_slice/stack_13gradients_1/loss_2/users_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
:*
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
k
)gradients_1/loss_2/users_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients_1/loss_2/users_grad/concatConcatV2(gradients_1/loss_2/users_grad/ExpandDims+gradients_1/loss_2/users_grad/strided_slice)gradients_1/loss_2/users_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
%gradients_1/loss_2/users_grad/ReshapeReshapegradients_1/AddN_2$gradients_1/loss_2/users_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
'gradients_1/loss_2/users_grad/Reshape_1Reshapeplaceholders_1/sampled_users(gradients_1/loss_2/users_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
q
!gradients_1/loss_2/sub_grad/ShapeShapeloss_2/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_1/loss_2/sub_grad/Shape_1Shapeloss_2/neg_items*
_output_shapes
:*
T0*
out_type0
�
1gradients_1/loss_2/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/sub_grad/Shape#gradients_1/loss_2/sub_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/sub_grad/SumSum6gradients_1/loss_2/mul_grad/tuple/control_dependency_11gradients_1/loss_2/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/sub_grad/ReshapeReshapegradients_1/loss_2/sub_grad/Sum!gradients_1/loss_2/sub_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
!gradients_1/loss_2/sub_grad/Sum_1Sum6gradients_1/loss_2/mul_grad/tuple/control_dependency_13gradients_1/loss_2/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
l
gradients_1/loss_2/sub_grad/NegNeg!gradients_1/loss_2/sub_grad/Sum_1*
_output_shapes
:*
T0
�
%gradients_1/loss_2/sub_grad/Reshape_1Reshapegradients_1/loss_2/sub_grad/Neg#gradients_1/loss_2/sub_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
�
,gradients_1/loss_2/sub_grad/tuple/group_depsNoOp$^gradients_1/loss_2/sub_grad/Reshape&^gradients_1/loss_2/sub_grad/Reshape_1
�
4gradients_1/loss_2/sub_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/sub_grad/Reshape-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*6
_class,
*(loc:@gradients_1/loss_2/sub_grad/Reshape
�
6gradients_1/loss_2/sub_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/sub_grad/Reshape_1-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_grad/Reshape_1
�
gradients_1/AddN_3AddN6gradients_1/loss_2/pow_1_grad/tuple/control_dependency4gradients_1/loss_2/sub_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape*
T0
�
'gradients_1/loss_2/pos_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *+
_class!
loc:@variables_1/item_factors
�
&gradients_1/loss_2/pos_items_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/pos_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/pos_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/pos_items_grad/Size0gradients_1/loss_2/pos_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients_1/loss_2/pos_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients_1/loss_2/pos_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/pos_items_grad/Shape5gradients_1/loss_2/pos_items_grad/strided_slice/stack7gradients_1/loss_2/pos_items_grad/strided_slice/stack_17gradients_1/loss_2/pos_items_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
:*
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
o
-gradients_1/loss_2/pos_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients_1/loss_2/pos_items_grad/concatConcatV2,gradients_1/loss_2/pos_items_grad/ExpandDims/gradients_1/loss_2/pos_items_grad/strided_slice-gradients_1/loss_2/pos_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients_1/loss_2/pos_items_grad/ReshapeReshapegradients_1/AddN_3(gradients_1/loss_2/pos_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
+gradients_1/loss_2/pos_items_grad/Reshape_1Reshape placeholders_1/sampled_pos_items,gradients_1/loss_2/pos_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients_1/AddN_4AddN6gradients_1/loss_2/pow_3_grad/tuple/control_dependency6gradients_1/loss_2/sub_grad/tuple/control_dependency_1*'
_output_shapes
:���������
*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape*
T0
�
'gradients_1/loss_2/neg_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *+
_class!
loc:@variables_1/item_factors
�
&gradients_1/loss_2/neg_items_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/neg_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/neg_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/neg_items_grad/Size0gradients_1/loss_2/neg_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients_1/loss_2/neg_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients_1/loss_2/neg_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/neg_items_grad/Shape5gradients_1/loss_2/neg_items_grad/strided_slice/stack7gradients_1/loss_2/neg_items_grad/strided_slice/stack_17gradients_1/loss_2/neg_items_grad/strided_slice/stack_2*
ellipsis_mask *
_output_shapes
:*
shrink_axis_mask *

begin_mask *
T0*
Index0*
new_axis_mask *
end_mask
o
-gradients_1/loss_2/neg_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients_1/loss_2/neg_items_grad/concatConcatV2,gradients_1/loss_2/neg_items_grad/ExpandDims/gradients_1/loss_2/neg_items_grad/strided_slice-gradients_1/loss_2/neg_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients_1/loss_2/neg_items_grad/ReshapeReshapegradients_1/AddN_4(gradients_1/loss_2/neg_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
+gradients_1/loss_2/neg_items_grad/Reshape_1Reshape placeholders_1/sampled_neg_items,gradients_1/loss_2/neg_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
[
gradients_1/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concat_2ConcatV2)gradients_1/loss_2/pos_items_grad/Reshape)gradients_1/loss_2/neg_items_grad/Reshapegradients_1/concat_2/axis*0
_output_shapes
:������������������*
N*

Tidx0*
T0
[
gradients_1/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concat_3ConcatV2+gradients_1/loss_2/pos_items_grad/Reshape_1+gradients_1/loss_2/neg_items_grad/Reshape_1gradients_1/concat_3/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
d
GradientDescent_1/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *���=
�
5GradientDescent_1/update_variables_1/user_factors/mulMul%gradients_1/loss_2/users_grad/ReshapeGradientDescent_1/learning_rate*0
_output_shapes
:������������������*
T0*+
_class!
loc:@variables_1/user_factors
�
<GradientDescent_1/update_variables_1/user_factors/ScatterSub
ScatterSubvariables_1/user_factors'gradients_1/loss_2/users_grad/Reshape_15GradientDescent_1/update_variables_1/user_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *+
_class!
loc:@variables_1/user_factors
�
5GradientDescent_1/update_variables_1/item_factors/mulMulgradients_1/concat_2GradientDescent_1/learning_rate*0
_output_shapes
:������������������*
T0*+
_class!
loc:@variables_1/item_factors
�
<GradientDescent_1/update_variables_1/item_factors/ScatterSub
ScatterSubvariables_1/item_factorsgradients_1/concat_35GradientDescent_1/update_variables_1/item_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *+
_class!
loc:@variables_1/item_factors
�
2GradientDescent_1/update_variables_1/item_bias/mulMulgradients_1/concatGradientDescent_1/learning_rate*#
_output_shapes
:���������*
T0*(
_class
loc:@variables_1/item_bias
�
9GradientDescent_1/update_variables_1/item_bias/ScatterSub
ScatterSubvariables_1/item_biasgradients_1/concat_12GradientDescent_1/update_variables_1/item_bias/mul*
_output_shapes	
:�*
T0*
Tindices0*
use_locking( *(
_class
loc:@variables_1/item_bias
�
GradientDescent_1NoOp=^GradientDescent_1/update_variables_1/user_factors/ScatterSub=^GradientDescent_1/update_variables_1/item_factors/ScatterSub:^GradientDescent_1/update_variables_1/item_bias/ScatterSub
R
loss_3/tagsConst*
_output_shapes
: *
dtype0*
valueB Bloss_3
S
loss_3ScalarSummaryloss_3/tagsloss_2/sub_2*
_output_shapes
: *
T0
U
Merge_1/MergeSummaryMergeSummaryloss_1loss_3*
_output_shapes
: *
N
�
init_1NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign"9�H��I     ��x�	�zLP�^�AJ��	
��
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
2	��
x
Assign
ref"T�

value"T

output_ref"T�"	
Ttype"
validate_shapebool("
use_lockingbool(�
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
�
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
2	�
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
2	�
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
�

ScatterSub
ref"T�
indices"Tindices
updates"T

output_ref"T�"
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
�
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
�
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
2	�
s

VariableV2
ref"dtype�"
shapeshape"
dtypetype"
	containerstring "
shared_namestring �
&
	ZerosLike
x"T
y"T"	
Ttype*1.1.02v1.1.0-rc0-61-g1ec6ed5��
h
placeholders/sampled_usersPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
l
placeholders/sampled_pos_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
l
placeholders/sampled_neg_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
q
 variables/truncated_normal/shapeConst*
_output_shapes
:*
dtype0*
valueB"  
   
d
variables/truncated_normal/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
f
!variables/truncated_normal/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2�	*
seed���)*
dtype0*
T0*
_output_shapes
:	�

�
variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	�
*
T0
�
variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	�
*
T0
s
"variables/truncated_normal_1/shapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   
f
!variables/truncated_normal_1/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
h
#variables/truncated_normal_1/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2�	*
seed���)*
dtype0*
T0*
_output_shapes
:	�

�
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	�
*
T0
�
variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	�
*
T0
�
variables/user_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/user_factors*
_output_shapes
:	�

�
variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	�
*
T0*)
_class
loc:@variables/user_factors
�
variables/item_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/item_factors*
_output_shapes
:	�

�
variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	�
*
T0*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
_output_shapes	
:�*
dtype0*
valueB�*    
�
variables/item_bias
VariableV2*
_output_shapes	
:�*
dtype0*
shape:�*
shared_name *
	container 
�
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
validate_shape(*
T0*
use_locking(*&
_class
loc:@variables/item_bias*
_output_shapes	
:�
�
variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:�*
T0*&
_class
loc:@variables/item_bias
�

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
�
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:���������
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:���������
*
T0
\
loss/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :
�
loss/SumSumloss/mulloss/Sum/reduction_indices*#
_output_shapes
:���������*
	keep_dims( *

Tidx0*
T0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:���������*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:���������*
T0
G
loss/NegNegloss/add*#
_output_shapes
:���������*
T0
G
loss/ExpExploss/Neg*#
_output_shapes
:���������*
T0
Q
loss/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
W

loss/add_1Addloss/add_1/xloss/Exp*#
_output_shapes
:���������*
T0
I
loss/LogLog
loss/add_1*#
_output_shapes
:���������*
T0
I

loss/Neg_1Negloss/Log*#
_output_shapes
:���������*
T0
T

loss/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
O

loss/pow/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y
loss/powPow
loss/users
loss/pow/y*'
_output_shapes
:���������
*
T0
]
loss/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       
g

loss/Sum_2Sumloss/powloss/Const_1*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
_output_shapes
: *
T0
Q
loss/pow_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*'
_output_shapes
:���������
*
T0
]
loss/Const_2Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss/mul_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
_output_shapes
: *
T0
Q
loss/pow_2/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*#
_output_shapes
:���������*
T0
V
loss/Const_3Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
_output_shapes
: *
T0
Q
loss/pow_3/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*'
_output_shapes
:���������
*
T0
]
loss/Const_4Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss/mul_3/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
_output_shapes
: *
T0
Q
loss/pow_4/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*#
_output_shapes
:���������*
T0
V
loss/Const_5Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
_output_shapes
: *
T0
J

loss/add_4Add
loss/mul_1
loss/add_2*
_output_shapes
: *
T0
J

loss/add_5Add
loss/add_4
loss/add_3*
_output_shapes
: *
T0
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
_output_shapes
: *
T0
R
gradients/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
T
gradients/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
Y
gradients/FillFillgradients/Shapegradients/Const*
_output_shapes
: *
T0
b
gradients/loss/sub_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/sub_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
_output_shapes
:*
T0
�
#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
�
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
�
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1
b
gradients/loss/add_5_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_5_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
�
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape
�
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
b
gradients/loss/add_4_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
�
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
�
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1
b
gradients/loss/add_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
�
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
�
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*#
_output_shapes
:���������*
T0
b
gradients/loss/mul_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
�
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
�
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
�
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1
b
gradients/loss/add_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
�
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
�
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1
b
gradients/loss/mul_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
�
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
�
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
�
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
�
"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*#
_output_shapes
:���������*
T0
�
gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:���������*
T0
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

b
gradients/loss/mul_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
�
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
�
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
�
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:���������*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
h
#gradients/loss/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:���������*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:���������*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:���������*
T0
�
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
�
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
�
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1
b
gradients/loss/add_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
_output_shapes
:*
T0*
out_type0
�
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
�
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
�
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1
g
gradients/loss/pow_grad/ShapeShape
loss/users*
_output_shapes
:*
T0*
out_type0
b
gradients/loss/pow_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:���������
*
T0
b
gradients/loss/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
_output_shapes
: *
T0
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
f
!gradients/loss/pow_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:���������
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:���������
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
�
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
�
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
_output_shapes
:*
T0*
out_type0
�
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:���������*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
h
#gradients/loss/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:���������*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:���������*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:���������*
T0
�
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:���������*
T0
�
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
�
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
�
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:���������
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
h
#gradients/loss/pow_3_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:���������
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:���������
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:���������
*
T0
�
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
�
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
�
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1
�
gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*#
_output_shapes
:���������*
T0
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:���������
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0
�
gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
h
#gradients/loss/pow_1_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:���������
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:���������
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:���������
*
T0
�
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:���������
*
T0
�
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
�
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
�
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*#
_output_shapes
:���������*
T0
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
_output_shapes
:*
T0*
out_type0
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
_output_shapes
:*
T0*
out_type0
�
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
�
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
�
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
_output_shapes
:*
T0*
out_type0
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
_output_shapes
:*
T0*
out_type0
�
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
_output_shapes
:*
T0
�
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
�
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
�
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
_output_shapes
:*
T0*
out_type0
^
gradients/loss/Sum_grad/SizeConst*
_output_shapes
: *
dtype0*
value	B :
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
�
gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
b
gradients/loss/Sum_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
e
#gradients/loss/Sum_grad/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
e
#gradients/loss/Sum_grad/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
d
"gradients/loss/Sum_grad/Fill/valueConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
�
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:���������*
N*
T0
c
!gradients/loss/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:���������*
T0
�
 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
�
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
�
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*
T0*'
_output_shapes
:���������

�
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:���������*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0
�
'gradients/loss/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*&
_class
loc:@variables/item_bias

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
: *
T0*
end_mask
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:���������*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0
�
'gradients/loss/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*&
_class
loc:@variables/item_bias

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
: *
T0*
end_mask
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
g
gradients/loss/mul_grad/ShapeShape
loss/users*
_output_shapes
:*
T0*
out_type0
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
_output_shapes
:*
T0*
out_type0
�
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:���������
*
T0
�
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:���������
*
T0
�
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
�
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
�
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1
W
gradients/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
Y
gradients/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
�
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0
�
gradients/loss/users_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"  
   *)
_class
loc:@variables/user_factors
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
_output_shapes
: *
T0*
out_type0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
w
-gradients/loss/users_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
:*
T0*
end_mask
g
%gradients/loss/users_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
_output_shapes
:*
T0*
out_type0
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
_output_shapes
:*
T0*
out_type0
�
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
_output_shapes
:*
T0
�
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
�
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
�
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
�
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0
�
#gradients/loss/pos_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *)
_class
loc:@variables/item_factors
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
:*
T0*
end_mask
k
)gradients/loss/pos_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:���������
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0
�
#gradients/loss/neg_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *)
_class
loc:@variables/item_factors
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
:*
T0*
end_mask
k
)gradients/loss/neg_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
Y
gradients/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*0
_output_shapes
:������������������*
N*

Tidx0*
T0
Y
gradients/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
b
GradientDescent/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *���=
�
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:������������������*
T0*)
_class
loc:@variables/user_factors
�
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/user_factors
�
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:������������������*
T0*)
_class
loc:@variables/item_factors
�
8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/item_factors
�
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:���������*
T0*&
_class
loc:@variables/item_bias
�
5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
_output_shapes	
:�*
T0*
Tindices0*
use_locking( *&
_class
loc:@variables/item_bias
�
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
_output_shapes
: *
dtype0*
valueB Bloss_1
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
_output_shapes
: *
T0
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign
j
placeholders_1/sampled_usersPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
n
 placeholders_1/sampled_pos_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
n
 placeholders_1/sampled_neg_itemsPlaceholder*#
_output_shapes
:���������*
dtype0*
shape: 
s
"variables_1/truncated_normal/shapeConst*
_output_shapes
:*
dtype0*
valueB"  
   
f
!variables_1/truncated_normal/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
h
#variables_1/truncated_normal/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
,variables_1/truncated_normal/TruncatedNormalTruncatedNormal"variables_1/truncated_normal/shape*
seed2�	*
seed���)*
dtype0*
T0*
_output_shapes
:	�

�
 variables_1/truncated_normal/mulMul,variables_1/truncated_normal/TruncatedNormal#variables_1/truncated_normal/stddev*
_output_shapes
:	�
*
T0
�
variables_1/truncated_normalAdd variables_1/truncated_normal/mul!variables_1/truncated_normal/mean*
_output_shapes
:	�
*
T0
u
$variables_1/truncated_normal_1/shapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   
h
#variables_1/truncated_normal_1/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
j
%variables_1/truncated_normal_1/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
.variables_1/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_1/truncated_normal_1/shape*
seed2�	*
seed���)*
dtype0*
T0*
_output_shapes
:	�

�
"variables_1/truncated_normal_1/mulMul.variables_1/truncated_normal_1/TruncatedNormal%variables_1/truncated_normal_1/stddev*
_output_shapes
:	�
*
T0
�
variables_1/truncated_normal_1Add"variables_1/truncated_normal_1/mul#variables_1/truncated_normal_1/mean*
_output_shapes
:	�
*
T0
�
variables_1/user_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables_1/user_factors/AssignAssignvariables_1/user_factorsvariables_1/truncated_normal*
validate_shape(*
T0*
use_locking(*+
_class!
loc:@variables_1/user_factors*
_output_shapes
:	�

�
variables_1/user_factors/readIdentityvariables_1/user_factors*
_output_shapes
:	�
*
T0*+
_class!
loc:@variables_1/user_factors
�
variables_1/item_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
shape:	�
*
shared_name *
	container 
�
variables_1/item_factors/AssignAssignvariables_1/item_factorsvariables_1/truncated_normal_1*
validate_shape(*
T0*
use_locking(*+
_class!
loc:@variables_1/item_factors*
_output_shapes
:	�

�
variables_1/item_factors/readIdentityvariables_1/item_factors*
_output_shapes
:	�
*
T0*+
_class!
loc:@variables_1/item_factors
`
variables_1/zerosConst*
_output_shapes	
:�*
dtype0*
valueB�*    
�
variables_1/item_bias
VariableV2*
_output_shapes	
:�*
dtype0*
shape:�*
shared_name *
	container 
�
variables_1/item_bias/AssignAssignvariables_1/item_biasvariables_1/zeros*
validate_shape(*
T0*
use_locking(*(
_class
loc:@variables_1/item_bias*
_output_shapes	
:�
�
variables_1/item_bias/readIdentityvariables_1/item_bias*
_output_shapes	
:�*
T0*(
_class
loc:@variables_1/item_bias
�
loss_2/usersGathervariables_1/user_factors/readplaceholders_1/sampled_users*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/pos_itemsGathervariables_1/item_factors/read placeholders_1/sampled_pos_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/neg_itemsGathervariables_1/item_factors/read placeholders_1/sampled_neg_items*'
_output_shapes
:���������
*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/pos_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_pos_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
�
loss_2/neg_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_neg_items*#
_output_shapes
:���������*
validate_indices(*
Tindices0*
Tparams0
g

loss_2/subSubloss_2/pos_itemsloss_2/neg_items*'
_output_shapes
:���������
*
T0
]

loss_2/mulMulloss_2/users
loss_2/sub*'
_output_shapes
:���������
*
T0
^
loss_2/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :
�

loss_2/SumSum
loss_2/mulloss_2/Sum/reduction_indices*#
_output_shapes
:���������*
	keep_dims( *

Tidx0*
T0
m
loss_2/sub_1Subloss_2/pos_item_biasloss_2/neg_item_bias*#
_output_shapes
:���������*
T0
Y

loss_2/addAddloss_2/sub_1
loss_2/Sum*#
_output_shapes
:���������*
T0
K

loss_2/NegNeg
loss_2/add*#
_output_shapes
:���������*
T0
K

loss_2/ExpExp
loss_2/Neg*#
_output_shapes
:���������*
T0
S
loss_2/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
]
loss_2/add_1Addloss_2/add_1/x
loss_2/Exp*#
_output_shapes
:���������*
T0
M

loss_2/LogLogloss_2/add_1*#
_output_shapes
:���������*
T0
M
loss_2/Neg_1Neg
loss_2/Log*#
_output_shapes
:���������*
T0
V
loss_2/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
m
loss_2/Sum_1Sumloss_2/Neg_1loss_2/Const*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
Q
loss_2/pow/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
_

loss_2/powPowloss_2/usersloss_2/pow/y*'
_output_shapes
:���������
*
T0
_
loss_2/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       
m
loss_2/Sum_2Sum
loss_2/powloss_2/Const_1*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
S
loss_2/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
R
loss_2/mul_1Mulloss_2/mul_1/xloss_2/Sum_2*
_output_shapes
: *
T0
S
loss_2/pow_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_1Powloss_2/pos_itemsloss_2/pow_1/y*'
_output_shapes
:���������
*
T0
_
loss_2/Const_2Const*
_output_shapes
:*
dtype0*
valueB"       
o
loss_2/Sum_3Sumloss_2/pow_1loss_2/Const_2*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
S
loss_2/mul_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
R
loss_2/mul_2Mulloss_2/mul_2/xloss_2/Sum_3*
_output_shapes
: *
T0
S
loss_2/pow_2/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_2Powloss_2/pos_item_biasloss_2/pow_2/y*#
_output_shapes
:���������*
T0
X
loss_2/Const_3Const*
_output_shapes
:*
dtype0*
valueB: 
o
loss_2/Sum_4Sumloss_2/pow_2loss_2/Const_3*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
P
loss_2/add_2Addloss_2/mul_2loss_2/Sum_4*
_output_shapes
: *
T0
S
loss_2/pow_3/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_3Powloss_2/neg_itemsloss_2/pow_3/y*'
_output_shapes
:���������
*
T0
_
loss_2/Const_4Const*
_output_shapes
:*
dtype0*
valueB"       
o
loss_2/Sum_5Sumloss_2/pow_3loss_2/Const_4*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
S
loss_2/mul_3/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
R
loss_2/mul_3Mulloss_2/mul_3/xloss_2/Sum_5*
_output_shapes
: *
T0
S
loss_2/pow_4/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
g
loss_2/pow_4Powloss_2/neg_item_biasloss_2/pow_4/y*#
_output_shapes
:���������*
T0
X
loss_2/Const_5Const*
_output_shapes
:*
dtype0*
valueB: 
o
loss_2/Sum_6Sumloss_2/pow_4loss_2/Const_5*
_output_shapes
: *
	keep_dims( *

Tidx0*
T0
P
loss_2/add_3Addloss_2/mul_3loss_2/Sum_6*
_output_shapes
: *
T0
P
loss_2/add_4Addloss_2/mul_1loss_2/add_2*
_output_shapes
: *
T0
P
loss_2/add_5Addloss_2/add_4loss_2/add_3*
_output_shapes
: *
T0
P
loss_2/sub_2Subloss_2/add_5loss_2/Sum_1*
_output_shapes
: *
T0
T
gradients_1/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
V
gradients_1/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
_
gradients_1/FillFillgradients_1/Shapegradients_1/Const*
_output_shapes
: *
T0
f
#gradients_1/loss_2/sub_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/sub_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_2_grad/Shape%gradients_1/loss_2/sub_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/sub_2_grad/SumSumgradients_1/Fill3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/sub_2_grad/ReshapeReshape!gradients_1/loss_2/sub_2_grad/Sum#gradients_1/loss_2/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/sub_2_grad/Sum_1Sumgradients_1/Fill5gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
p
!gradients_1/loss_2/sub_2_grad/NegNeg#gradients_1/loss_2/sub_2_grad/Sum_1*
_output_shapes
:*
T0
�
'gradients_1/loss_2/sub_2_grad/Reshape_1Reshape!gradients_1/loss_2/sub_2_grad/Neg%gradients_1/loss_2/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/sub_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_2_grad/Reshape(^gradients_1/loss_2/sub_2_grad/Reshape_1
�
6gradients_1/loss_2/sub_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_2_grad/Reshape/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_2_grad/Reshape
�
8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_2_grad/Reshape_1/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/sub_2_grad/Reshape_1
f
#gradients_1/loss_2/add_5_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_5_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_5_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_5_grad/Shape%gradients_1/loss_2/add_5_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_5_grad/SumSum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency3gradients_1/loss_2/add_5_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_5_grad/ReshapeReshape!gradients_1/loss_2/add_5_grad/Sum#gradients_1/loss_2/add_5_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_5_grad/Sum_1Sum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency5gradients_1/loss_2/add_5_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_5_grad/Reshape_1Reshape#gradients_1/loss_2/add_5_grad/Sum_1%gradients_1/loss_2/add_5_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_5_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_5_grad/Reshape(^gradients_1/loss_2/add_5_grad/Reshape_1
�
6gradients_1/loss_2/add_5_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_5_grad/Reshape/^gradients_1/loss_2/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_5_grad/Reshape
�
8gradients_1/loss_2/add_5_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_5_grad/Reshape_1/^gradients_1/loss_2/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_5_grad/Reshape_1
u
+gradients_1/loss_2/Sum_1_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
%gradients_1/loss_2/Sum_1_grad/ReshapeReshape8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_1_grad/ShapeShapeloss_2/Neg_1*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_1_grad/TileTile%gradients_1/loss_2/Sum_1_grad/Reshape#gradients_1/loss_2/Sum_1_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
f
#gradients_1/loss_2/add_4_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_4_grad/Shape%gradients_1/loss_2/add_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_4_grad/SumSum6gradients_1/loss_2/add_5_grad/tuple/control_dependency3gradients_1/loss_2/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_4_grad/ReshapeReshape!gradients_1/loss_2/add_4_grad/Sum#gradients_1/loss_2/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_4_grad/Sum_1Sum6gradients_1/loss_2/add_5_grad/tuple/control_dependency5gradients_1/loss_2/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_4_grad/Reshape_1Reshape#gradients_1/loss_2/add_4_grad/Sum_1%gradients_1/loss_2/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_4_grad/Reshape(^gradients_1/loss_2/add_4_grad/Reshape_1
�
6gradients_1/loss_2/add_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_4_grad/Reshape/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_4_grad/Reshape
�
8gradients_1/loss_2/add_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_4_grad/Reshape_1/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_4_grad/Reshape_1
f
#gradients_1/loss_2/add_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_3_grad/Shape%gradients_1/loss_2/add_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_3_grad/SumSum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_13gradients_1/loss_2/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_3_grad/ReshapeReshape!gradients_1/loss_2/add_3_grad/Sum#gradients_1/loss_2/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_3_grad/Sum_1Sum8gradients_1/loss_2/add_5_grad/tuple/control_dependency_15gradients_1/loss_2/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_3_grad/Reshape_1Reshape#gradients_1/loss_2/add_3_grad/Sum_1%gradients_1/loss_2/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_3_grad/Reshape(^gradients_1/loss_2/add_3_grad/Reshape_1
�
6gradients_1/loss_2/add_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_3_grad/Reshape/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_3_grad/Reshape
�
8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_3_grad/Reshape_1/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_3_grad/Reshape_1
z
!gradients_1/loss_2/Neg_1_grad/NegNeg"gradients_1/loss_2/Sum_1_grad/Tile*#
_output_shapes
:���������*
T0
f
#gradients_1/loss_2/mul_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/mul_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_1_grad/Shape%gradients_1/loss_2/mul_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/mul_1_grad/mulMul6gradients_1/loss_2/add_4_grad/tuple/control_dependencyloss_2/Sum_2*
_output_shapes
: *
T0
�
!gradients_1/loss_2/mul_1_grad/SumSum!gradients_1/loss_2/mul_1_grad/mul3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_1_grad/ReshapeReshape!gradients_1/loss_2/mul_1_grad/Sum#gradients_1/loss_2/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/mul_1_grad/mul_1Mulloss_2/mul_1/x6gradients_1/loss_2/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
#gradients_1/loss_2/mul_1_grad/Sum_1Sum#gradients_1/loss_2/mul_1_grad/mul_15gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/mul_1_grad/Reshape_1Reshape#gradients_1/loss_2/mul_1_grad/Sum_1%gradients_1/loss_2/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/mul_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_1_grad/Reshape(^gradients_1/loss_2/mul_1_grad/Reshape_1
�
6gradients_1/loss_2/mul_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_1_grad/Reshape/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_1_grad/Reshape
�
8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_1_grad/Reshape_1/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_1_grad/Reshape_1
f
#gradients_1/loss_2/add_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/add_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_2_grad/Shape%gradients_1/loss_2/add_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_2_grad/SumSum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_13gradients_1/loss_2/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_2_grad/ReshapeReshape!gradients_1/loss_2/add_2_grad/Sum#gradients_1/loss_2/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_2_grad/Sum_1Sum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_15gradients_1/loss_2/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_2_grad/Reshape_1Reshape#gradients_1/loss_2/add_2_grad/Sum_1%gradients_1/loss_2/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/add_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_2_grad/Reshape(^gradients_1/loss_2/add_2_grad/Reshape_1
�
6gradients_1/loss_2/add_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_2_grad/Reshape/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_2_grad/Reshape
�
8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_2_grad/Reshape_1/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_2_grad/Reshape_1
f
#gradients_1/loss_2/mul_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/mul_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_3_grad/Shape%gradients_1/loss_2/mul_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/mul_3_grad/mulMul6gradients_1/loss_2/add_3_grad/tuple/control_dependencyloss_2/Sum_5*
_output_shapes
: *
T0
�
!gradients_1/loss_2/mul_3_grad/SumSum!gradients_1/loss_2/mul_3_grad/mul3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_3_grad/ReshapeReshape!gradients_1/loss_2/mul_3_grad/Sum#gradients_1/loss_2/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/mul_3_grad/mul_1Mulloss_2/mul_3/x6gradients_1/loss_2/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
#gradients_1/loss_2/mul_3_grad/Sum_1Sum#gradients_1/loss_2/mul_3_grad/mul_15gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/mul_3_grad/Reshape_1Reshape#gradients_1/loss_2/mul_3_grad/Sum_1%gradients_1/loss_2/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/mul_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_3_grad/Reshape(^gradients_1/loss_2/mul_3_grad/Reshape_1
�
6gradients_1/loss_2/mul_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_3_grad/Reshape/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_3_grad/Reshape
�
8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_3_grad/Reshape_1/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_3_grad/Reshape_1
u
+gradients_1/loss_2/Sum_6_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
%gradients_1/loss_2/Sum_6_grad/ReshapeReshape8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_6_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_6_grad/ShapeShapeloss_2/pow_4*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_6_grad/TileTile%gradients_1/loss_2/Sum_6_grad/Reshape#gradients_1/loss_2/Sum_6_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
�
&gradients_1/loss_2/Log_grad/Reciprocal
Reciprocalloss_2/add_1"^gradients_1/loss_2/Neg_1_grad/Neg*#
_output_shapes
:���������*
T0
�
gradients_1/loss_2/Log_grad/mulMul!gradients_1/loss_2/Neg_1_grad/Neg&gradients_1/loss_2/Log_grad/Reciprocal*#
_output_shapes
:���������*
T0
|
+gradients_1/loss_2/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
%gradients_1/loss_2/Sum_2_grad/ReshapeReshape8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_2_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
m
#gradients_1/loss_2/Sum_2_grad/ShapeShape
loss_2/pow*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_2_grad/TileTile%gradients_1/loss_2/Sum_2_grad/Reshape#gradients_1/loss_2/Sum_2_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

f
#gradients_1/loss_2/mul_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
h
%gradients_1/loss_2/mul_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_2_grad/Shape%gradients_1/loss_2/mul_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/mul_2_grad/mulMul6gradients_1/loss_2/add_2_grad/tuple/control_dependencyloss_2/Sum_3*
_output_shapes
: *
T0
�
!gradients_1/loss_2/mul_2_grad/SumSum!gradients_1/loss_2/mul_2_grad/mul3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_2_grad/ReshapeReshape!gradients_1/loss_2/mul_2_grad/Sum#gradients_1/loss_2/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/mul_2_grad/mul_1Mulloss_2/mul_2/x6gradients_1/loss_2/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
�
#gradients_1/loss_2/mul_2_grad/Sum_1Sum#gradients_1/loss_2/mul_2_grad/mul_15gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/mul_2_grad/Reshape_1Reshape#gradients_1/loss_2/mul_2_grad/Sum_1%gradients_1/loss_2/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/mul_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_2_grad/Reshape(^gradients_1/loss_2/mul_2_grad/Reshape_1
�
6gradients_1/loss_2/mul_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_2_grad/Reshape/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_2_grad/Reshape
�
8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_2_grad/Reshape_1/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_2_grad/Reshape_1
u
+gradients_1/loss_2/Sum_4_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
%gradients_1/loss_2/Sum_4_grad/ReshapeReshape8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_4_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_4_grad/ShapeShapeloss_2/pow_2*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_4_grad/TileTile%gradients_1/loss_2/Sum_4_grad/Reshape#gradients_1/loss_2/Sum_4_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:���������
|
+gradients_1/loss_2/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
%gradients_1/loss_2/Sum_5_grad/ReshapeReshape8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_5_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_5_grad/ShapeShapeloss_2/pow_3*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_5_grad/TileTile%gradients_1/loss_2/Sum_5_grad/Reshape#gradients_1/loss_2/Sum_5_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

w
#gradients_1/loss_2/pow_4_grad/ShapeShapeloss_2/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_4_grad/Shape%gradients_1/loss_2/pow_4_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_4_grad/mulMul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4/y*#
_output_shapes
:���������*
T0
h
#gradients_1/loss_2/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_4_grad/subSubloss_2/pow_4/y#gradients_1/loss_2/pow_4_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_4_grad/PowPowloss_2/neg_item_bias!gradients_1/loss_2/pow_4_grad/sub*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/mul_1Mul!gradients_1/loss_2/pow_4_grad/mul!gradients_1/loss_2/pow_4_grad/Pow*#
_output_shapes
:���������*
T0
�
!gradients_1/loss_2/pow_4_grad/SumSum#gradients_1/loss_2/pow_4_grad/mul_13gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_4_grad/ReshapeReshape!gradients_1/loss_2/pow_4_grad/Sum#gradients_1/loss_2/pow_4_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
l
'gradients_1/loss_2/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_4_grad/GreaterGreaterloss_2/neg_item_bias'gradients_1/loss_2/pow_4_grad/Greater/y*#
_output_shapes
:���������*
T0
l
!gradients_1/loss_2/pow_4_grad/LogLogloss_2/neg_item_bias*#
_output_shapes
:���������*
T0
y
(gradients_1/loss_2/pow_4_grad/zeros_like	ZerosLikeloss_2/neg_item_bias*#
_output_shapes
:���������*
T0
�
$gradients_1/loss_2/pow_4_grad/SelectSelect%gradients_1/loss_2/pow_4_grad/Greater!gradients_1/loss_2/pow_4_grad/Log(gradients_1/loss_2/pow_4_grad/zeros_like*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/mul_2Mul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/mul_3Mul#gradients_1/loss_2/pow_4_grad/mul_2$gradients_1/loss_2/pow_4_grad/Select*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_4_grad/Sum_1Sum#gradients_1/loss_2/pow_4_grad/mul_35gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_4_grad/Reshape_1Reshape#gradients_1/loss_2/pow_4_grad/Sum_1%gradients_1/loss_2/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_4_grad/Reshape(^gradients_1/loss_2/pow_4_grad/Reshape_1
�
6gradients_1/loss_2/pow_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_4_grad/Reshape/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape
�
8gradients_1/loss_2/pow_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_4_grad/Reshape_1/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_4_grad/Reshape_1
f
#gradients_1/loss_2/add_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
o
%gradients_1/loss_2/add_1_grad/Shape_1Shape
loss_2/Exp*
_output_shapes
:*
T0*
out_type0
�
3gradients_1/loss_2/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_1_grad/Shape%gradients_1/loss_2/add_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/add_1_grad/SumSumgradients_1/loss_2/Log_grad/mul3gradients_1/loss_2/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_1_grad/ReshapeReshape!gradients_1/loss_2/add_1_grad/Sum#gradients_1/loss_2/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
�
#gradients_1/loss_2/add_1_grad/Sum_1Sumgradients_1/loss_2/Log_grad/mul5gradients_1/loss_2/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/add_1_grad/Reshape_1Reshape#gradients_1/loss_2/add_1_grad/Sum_1%gradients_1/loss_2/add_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
�
.gradients_1/loss_2/add_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_1_grad/Reshape(^gradients_1/loss_2/add_1_grad/Reshape_1
�
6gradients_1/loss_2/add_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_1_grad/Reshape/^gradients_1/loss_2/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_1_grad/Reshape
�
8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_1_grad/Reshape_1/^gradients_1/loss_2/add_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*:
_class0
.,loc:@gradients_1/loss_2/add_1_grad/Reshape_1
m
!gradients_1/loss_2/pow_grad/ShapeShapeloss_2/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_1/loss_2/pow_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
1gradients_1/loss_2/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/pow_grad/Shape#gradients_1/loss_2/pow_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/pow_grad/mulMul"gradients_1/loss_2/Sum_2_grad/Tileloss_2/pow/y*'
_output_shapes
:���������
*
T0
f
!gradients_1/loss_2/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
x
gradients_1/loss_2/pow_grad/subSubloss_2/pow/y!gradients_1/loss_2/pow_grad/sub/y*
_output_shapes
: *
T0
�
gradients_1/loss_2/pow_grad/PowPowloss_2/usersgradients_1/loss_2/pow_grad/sub*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/mul_1Mulgradients_1/loss_2/pow_grad/mulgradients_1/loss_2/pow_grad/Pow*'
_output_shapes
:���������
*
T0
�
gradients_1/loss_2/pow_grad/SumSum!gradients_1/loss_2/pow_grad/mul_11gradients_1/loss_2/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/pow_grad/ReshapeReshapegradients_1/loss_2/pow_grad/Sum!gradients_1/loss_2/pow_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
j
%gradients_1/loss_2/pow_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
#gradients_1/loss_2/pow_grad/GreaterGreaterloss_2/users%gradients_1/loss_2/pow_grad/Greater/y*'
_output_shapes
:���������
*
T0
f
gradients_1/loss_2/pow_grad/LogLogloss_2/users*'
_output_shapes
:���������
*
T0
s
&gradients_1/loss_2/pow_grad/zeros_like	ZerosLikeloss_2/users*'
_output_shapes
:���������
*
T0
�
"gradients_1/loss_2/pow_grad/SelectSelect#gradients_1/loss_2/pow_grad/Greatergradients_1/loss_2/pow_grad/Log&gradients_1/loss_2/pow_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/mul_2Mul"gradients_1/loss_2/Sum_2_grad/Tile
loss_2/pow*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/mul_3Mul!gradients_1/loss_2/pow_grad/mul_2"gradients_1/loss_2/pow_grad/Select*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_grad/Sum_1Sum!gradients_1/loss_2/pow_grad/mul_33gradients_1/loss_2/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_grad/Reshape_1Reshape!gradients_1/loss_2/pow_grad/Sum_1#gradients_1/loss_2/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
,gradients_1/loss_2/pow_grad/tuple/group_depsNoOp$^gradients_1/loss_2/pow_grad/Reshape&^gradients_1/loss_2/pow_grad/Reshape_1
�
4gradients_1/loss_2/pow_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/pow_grad/Reshape-^gradients_1/loss_2/pow_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape
�
6gradients_1/loss_2/pow_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/pow_grad/Reshape_1-^gradients_1/loss_2/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_grad/Reshape_1
|
+gradients_1/loss_2/Sum_3_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
%gradients_1/loss_2/Sum_3_grad/ReshapeReshape8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_3_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_1/loss_2/Sum_3_grad/ShapeShapeloss_2/pow_1*
_output_shapes
:*
T0*
out_type0
�
"gradients_1/loss_2/Sum_3_grad/TileTile%gradients_1/loss_2/Sum_3_grad/Reshape#gradients_1/loss_2/Sum_3_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:���������

w
#gradients_1/loss_2/pow_2_grad/ShapeShapeloss_2/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_2_grad/Shape%gradients_1/loss_2/pow_2_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_2_grad/mulMul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2/y*#
_output_shapes
:���������*
T0
h
#gradients_1/loss_2/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_2_grad/subSubloss_2/pow_2/y#gradients_1/loss_2/pow_2_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_2_grad/PowPowloss_2/pos_item_bias!gradients_1/loss_2/pow_2_grad/sub*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/mul_1Mul!gradients_1/loss_2/pow_2_grad/mul!gradients_1/loss_2/pow_2_grad/Pow*#
_output_shapes
:���������*
T0
�
!gradients_1/loss_2/pow_2_grad/SumSum#gradients_1/loss_2/pow_2_grad/mul_13gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_2_grad/ReshapeReshape!gradients_1/loss_2/pow_2_grad/Sum#gradients_1/loss_2/pow_2_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
l
'gradients_1/loss_2/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_2_grad/GreaterGreaterloss_2/pos_item_bias'gradients_1/loss_2/pow_2_grad/Greater/y*#
_output_shapes
:���������*
T0
l
!gradients_1/loss_2/pow_2_grad/LogLogloss_2/pos_item_bias*#
_output_shapes
:���������*
T0
y
(gradients_1/loss_2/pow_2_grad/zeros_like	ZerosLikeloss_2/pos_item_bias*#
_output_shapes
:���������*
T0
�
$gradients_1/loss_2/pow_2_grad/SelectSelect%gradients_1/loss_2/pow_2_grad/Greater!gradients_1/loss_2/pow_2_grad/Log(gradients_1/loss_2/pow_2_grad/zeros_like*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/mul_2Mul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/mul_3Mul#gradients_1/loss_2/pow_2_grad/mul_2$gradients_1/loss_2/pow_2_grad/Select*#
_output_shapes
:���������*
T0
�
#gradients_1/loss_2/pow_2_grad/Sum_1Sum#gradients_1/loss_2/pow_2_grad/mul_35gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_2_grad/Reshape_1Reshape#gradients_1/loss_2/pow_2_grad/Sum_1%gradients_1/loss_2/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_2_grad/Reshape(^gradients_1/loss_2/pow_2_grad/Reshape_1
�
6gradients_1/loss_2/pow_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_2_grad/Reshape/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape
�
8gradients_1/loss_2/pow_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_2_grad/Reshape_1/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_2_grad/Reshape_1
s
#gradients_1/loss_2/pow_3_grad/ShapeShapeloss_2/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_3_grad/Shape%gradients_1/loss_2/pow_3_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_3_grad/mulMul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3/y*'
_output_shapes
:���������
*
T0
h
#gradients_1/loss_2/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_3_grad/subSubloss_2/pow_3/y#gradients_1/loss_2/pow_3_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_3_grad/PowPowloss_2/neg_items!gradients_1/loss_2/pow_3_grad/sub*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/mul_1Mul!gradients_1/loss_2/pow_3_grad/mul!gradients_1/loss_2/pow_3_grad/Pow*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_3_grad/SumSum#gradients_1/loss_2/pow_3_grad/mul_13gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_3_grad/ReshapeReshape!gradients_1/loss_2/pow_3_grad/Sum#gradients_1/loss_2/pow_3_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
l
'gradients_1/loss_2/pow_3_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_3_grad/GreaterGreaterloss_2/neg_items'gradients_1/loss_2/pow_3_grad/Greater/y*'
_output_shapes
:���������
*
T0
l
!gradients_1/loss_2/pow_3_grad/LogLogloss_2/neg_items*'
_output_shapes
:���������
*
T0
y
(gradients_1/loss_2/pow_3_grad/zeros_like	ZerosLikeloss_2/neg_items*'
_output_shapes
:���������
*
T0
�
$gradients_1/loss_2/pow_3_grad/SelectSelect%gradients_1/loss_2/pow_3_grad/Greater!gradients_1/loss_2/pow_3_grad/Log(gradients_1/loss_2/pow_3_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/mul_2Mul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/mul_3Mul#gradients_1/loss_2/pow_3_grad/mul_2$gradients_1/loss_2/pow_3_grad/Select*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_3_grad/Sum_1Sum#gradients_1/loss_2/pow_3_grad/mul_35gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_3_grad/Reshape_1Reshape#gradients_1/loss_2/pow_3_grad/Sum_1%gradients_1/loss_2/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_3_grad/Reshape(^gradients_1/loss_2/pow_3_grad/Reshape_1
�
6gradients_1/loss_2/pow_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_3_grad/Reshape/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape
�
8gradients_1/loss_2/pow_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_3_grad/Reshape_1/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_3_grad/Reshape_1
�
gradients_1/loss_2/Exp_grad/mulMul8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1
loss_2/Exp*#
_output_shapes
:���������*
T0
s
#gradients_1/loss_2/pow_1_grad/ShapeShapeloss_2/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
3gradients_1/loss_2/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_1_grad/Shape%gradients_1/loss_2/pow_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/pow_1_grad/mulMul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1/y*'
_output_shapes
:���������
*
T0
h
#gradients_1/loss_2/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
~
!gradients_1/loss_2/pow_1_grad/subSubloss_2/pow_1/y#gradients_1/loss_2/pow_1_grad/sub/y*
_output_shapes
: *
T0
�
!gradients_1/loss_2/pow_1_grad/PowPowloss_2/pos_items!gradients_1/loss_2/pow_1_grad/sub*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/mul_1Mul!gradients_1/loss_2/pow_1_grad/mul!gradients_1/loss_2/pow_1_grad/Pow*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/pow_1_grad/SumSum#gradients_1/loss_2/pow_1_grad/mul_13gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/pow_1_grad/ReshapeReshape!gradients_1/loss_2/pow_1_grad/Sum#gradients_1/loss_2/pow_1_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
l
'gradients_1/loss_2/pow_1_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
%gradients_1/loss_2/pow_1_grad/GreaterGreaterloss_2/pos_items'gradients_1/loss_2/pow_1_grad/Greater/y*'
_output_shapes
:���������
*
T0
l
!gradients_1/loss_2/pow_1_grad/LogLogloss_2/pos_items*'
_output_shapes
:���������
*
T0
y
(gradients_1/loss_2/pow_1_grad/zeros_like	ZerosLikeloss_2/pos_items*'
_output_shapes
:���������
*
T0
�
$gradients_1/loss_2/pow_1_grad/SelectSelect%gradients_1/loss_2/pow_1_grad/Greater!gradients_1/loss_2/pow_1_grad/Log(gradients_1/loss_2/pow_1_grad/zeros_like*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/mul_2Mul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/mul_3Mul#gradients_1/loss_2/pow_1_grad/mul_2$gradients_1/loss_2/pow_1_grad/Select*'
_output_shapes
:���������
*
T0
�
#gradients_1/loss_2/pow_1_grad/Sum_1Sum#gradients_1/loss_2/pow_1_grad/mul_35gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
'gradients_1/loss_2/pow_1_grad/Reshape_1Reshape#gradients_1/loss_2/pow_1_grad/Sum_1%gradients_1/loss_2/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
�
.gradients_1/loss_2/pow_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_1_grad/Reshape(^gradients_1/loss_2/pow_1_grad/Reshape_1
�
6gradients_1/loss_2/pow_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_1_grad/Reshape/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape
�
8gradients_1/loss_2/pow_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_1_grad/Reshape_1/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_1_grad/Reshape_1
u
gradients_1/loss_2/Neg_grad/NegNeggradients_1/loss_2/Exp_grad/mul*#
_output_shapes
:���������*
T0
m
!gradients_1/loss_2/add_grad/ShapeShapeloss_2/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_1/loss_2/add_grad/Shape_1Shape
loss_2/Sum*
_output_shapes
:*
T0*
out_type0
�
1gradients_1/loss_2/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/add_grad/Shape#gradients_1/loss_2/add_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/add_grad/SumSumgradients_1/loss_2/Neg_grad/Neg1gradients_1/loss_2/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/add_grad/ReshapeReshapegradients_1/loss_2/add_grad/Sum!gradients_1/loss_2/add_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
!gradients_1/loss_2/add_grad/Sum_1Sumgradients_1/loss_2/Neg_grad/Neg3gradients_1/loss_2/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/add_grad/Reshape_1Reshape!gradients_1/loss_2/add_grad/Sum_1#gradients_1/loss_2/add_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
�
,gradients_1/loss_2/add_grad/tuple/group_depsNoOp$^gradients_1/loss_2/add_grad/Reshape&^gradients_1/loss_2/add_grad/Reshape_1
�
4gradients_1/loss_2/add_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/add_grad/Reshape-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*6
_class,
*(loc:@gradients_1/loss_2/add_grad/Reshape
�
6gradients_1/loss_2/add_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/add_grad/Reshape_1-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/add_grad/Reshape_1
w
#gradients_1/loss_2/sub_1_grad/ShapeShapeloss_2/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_1/loss_2/sub_1_grad/Shape_1Shapeloss_2/neg_item_bias*
_output_shapes
:*
T0*
out_type0
�
3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_1_grad/Shape%gradients_1/loss_2/sub_1_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
!gradients_1/loss_2/sub_1_grad/SumSum4gradients_1/loss_2/add_grad/tuple/control_dependency3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/sub_1_grad/ReshapeReshape!gradients_1/loss_2/sub_1_grad/Sum#gradients_1/loss_2/sub_1_grad/Shape*#
_output_shapes
:���������*
T0*
Tshape0
�
#gradients_1/loss_2/sub_1_grad/Sum_1Sum4gradients_1/loss_2/add_grad/tuple/control_dependency5gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
p
!gradients_1/loss_2/sub_1_grad/NegNeg#gradients_1/loss_2/sub_1_grad/Sum_1*
_output_shapes
:*
T0
�
'gradients_1/loss_2/sub_1_grad/Reshape_1Reshape!gradients_1/loss_2/sub_1_grad/Neg%gradients_1/loss_2/sub_1_grad/Shape_1*#
_output_shapes
:���������*
T0*
Tshape0
�
.gradients_1/loss_2/sub_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_1_grad/Reshape(^gradients_1/loss_2/sub_1_grad/Reshape_1
�
6gradients_1/loss_2/sub_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_1_grad/Reshape/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_1_grad/Reshape
�
8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_1_grad/Reshape_1/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:���������*
T0*:
_class0
.,loc:@gradients_1/loss_2/sub_1_grad/Reshape_1
k
!gradients_1/loss_2/Sum_grad/ShapeShape
loss_2/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_1/loss_2/Sum_grad/SizeConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients_1/loss_2/Sum_grad/addAddloss_2/Sum/reduction_indices gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
�
gradients_1/loss_2/Sum_grad/modFloorModgradients_1/loss_2/Sum_grad/add gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_1/loss_2/Sum_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
i
'gradients_1/loss_2/Sum_grad/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
i
'gradients_1/loss_2/Sum_grad/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
�
!gradients_1/loss_2/Sum_grad/rangeRange'gradients_1/loss_2/Sum_grad/range/start gradients_1/loss_2/Sum_grad/Size'gradients_1/loss_2/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_1/loss_2/Sum_grad/Fill/valueConst*
_output_shapes
: *
dtype0*
value	B :
�
 gradients_1/loss_2/Sum_grad/FillFill#gradients_1/loss_2/Sum_grad/Shape_1&gradients_1/loss_2/Sum_grad/Fill/value*
_output_shapes
: *
T0
�
)gradients_1/loss_2/Sum_grad/DynamicStitchDynamicStitch!gradients_1/loss_2/Sum_grad/rangegradients_1/loss_2/Sum_grad/mod!gradients_1/loss_2/Sum_grad/Shape gradients_1/loss_2/Sum_grad/Fill*#
_output_shapes
:���������*
N*
T0
g
%gradients_1/loss_2/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
�
#gradients_1/loss_2/Sum_grad/MaximumMaximum)gradients_1/loss_2/Sum_grad/DynamicStitch%gradients_1/loss_2/Sum_grad/Maximum/y*#
_output_shapes
:���������*
T0
�
$gradients_1/loss_2/Sum_grad/floordivFloorDiv!gradients_1/loss_2/Sum_grad/Shape#gradients_1/loss_2/Sum_grad/Maximum*
_output_shapes
:*
T0
�
#gradients_1/loss_2/Sum_grad/ReshapeReshape6gradients_1/loss_2/add_grad/tuple/control_dependency_1)gradients_1/loss_2/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
�
 gradients_1/loss_2/Sum_grad/TileTile#gradients_1/loss_2/Sum_grad/Reshape$gradients_1/loss_2/Sum_grad/floordiv*

Tmultiples0*
T0*'
_output_shapes
:���������

�
gradients_1/AddNAddN6gradients_1/loss_2/pow_2_grad/tuple/control_dependency6gradients_1/loss_2/sub_1_grad/tuple/control_dependency*#
_output_shapes
:���������*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape*
T0
�
+gradients_1/loss_2/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*(
_class
loc:@variables_1/item_bias
�
*gradients_1/loss_2/pos_item_bias_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
0gradients_1/loss_2/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/pos_item_bias_grad/Size4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
�
9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
3gradients_1/loss_2/pos_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/pos_item_bias_grad/Shape9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
: *
T0*
end_mask
s
1gradients_1/loss_2/pos_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/pos_item_bias_grad/concatConcatV20gradients_1/loss_2/pos_item_bias_grad/ExpandDims3gradients_1/loss_2/pos_item_bias_grad/strided_slice1gradients_1/loss_2/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
-gradients_1/loss_2/pos_item_bias_grad/ReshapeReshapegradients_1/AddN,gradients_1/loss_2/pos_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
/gradients_1/loss_2/pos_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_pos_items0gradients_1/loss_2/pos_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients_1/AddN_1AddN6gradients_1/loss_2/pow_4_grad/tuple/control_dependency8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:���������*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape*
T0
�
+gradients_1/loss_2/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*(
_class
loc:@variables_1/item_bias
�
*gradients_1/loss_2/neg_item_bias_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
0gradients_1/loss_2/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/neg_item_bias_grad/Size4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
�
9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
3gradients_1/loss_2/neg_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/neg_item_bias_grad/Shape9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
: *
T0*
end_mask
s
1gradients_1/loss_2/neg_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/neg_item_bias_grad/concatConcatV20gradients_1/loss_2/neg_item_bias_grad/ExpandDims3gradients_1/loss_2/neg_item_bias_grad/strided_slice1gradients_1/loss_2/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
-gradients_1/loss_2/neg_item_bias_grad/ReshapeReshapegradients_1/AddN_1,gradients_1/loss_2/neg_item_bias_grad/concat*#
_output_shapes
:���������*
T0*
Tshape0
�
/gradients_1/loss_2/neg_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_neg_items0gradients_1/loss_2/neg_item_bias_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
m
!gradients_1/loss_2/mul_grad/ShapeShapeloss_2/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_1/loss_2/mul_grad/Shape_1Shape
loss_2/sub*
_output_shapes
:*
T0*
out_type0
�
1gradients_1/loss_2/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/mul_grad/Shape#gradients_1/loss_2/mul_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/mul_grad/mulMul gradients_1/loss_2/Sum_grad/Tile
loss_2/sub*'
_output_shapes
:���������
*
T0
�
gradients_1/loss_2/mul_grad/SumSumgradients_1/loss_2/mul_grad/mul1gradients_1/loss_2/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/mul_grad/ReshapeReshapegradients_1/loss_2/mul_grad/Sum!gradients_1/loss_2/mul_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
!gradients_1/loss_2/mul_grad/mul_1Mulloss_2/users gradients_1/loss_2/Sum_grad/Tile*'
_output_shapes
:���������
*
T0
�
!gradients_1/loss_2/mul_grad/Sum_1Sum!gradients_1/loss_2/mul_grad/mul_13gradients_1/loss_2/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
%gradients_1/loss_2/mul_grad/Reshape_1Reshape!gradients_1/loss_2/mul_grad/Sum_1#gradients_1/loss_2/mul_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
�
,gradients_1/loss_2/mul_grad/tuple/group_depsNoOp$^gradients_1/loss_2/mul_grad/Reshape&^gradients_1/loss_2/mul_grad/Reshape_1
�
4gradients_1/loss_2/mul_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/mul_grad/Reshape-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*6
_class,
*(loc:@gradients_1/loss_2/mul_grad/Reshape
�
6gradients_1/loss_2/mul_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/mul_grad/Reshape_1-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_grad/Reshape_1
Y
gradients_1/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concatConcatV2-gradients_1/loss_2/pos_item_bias_grad/Reshape-gradients_1/loss_2/neg_item_bias_grad/Reshapegradients_1/concat/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
[
gradients_1/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concat_1ConcatV2/gradients_1/loss_2/pos_item_bias_grad/Reshape_1/gradients_1/loss_2/neg_item_bias_grad/Reshape_1gradients_1/concat_1/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
�
gradients_1/AddN_2AddN4gradients_1/loss_2/pow_grad/tuple/control_dependency4gradients_1/loss_2/mul_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape*
T0
�
#gradients_1/loss_2/users_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"  
   *+
_class!
loc:@variables_1/user_factors
y
"gradients_1/loss_2/users_grad/SizeSizeplaceholders_1/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_1/loss_2/users_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients_1/loss_2/users_grad/ExpandDims
ExpandDims"gradients_1/loss_2/users_grad/Size,gradients_1/loss_2/users_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0
{
1gradients_1/loss_2/users_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients_1/loss_2/users_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients_1/loss_2/users_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients_1/loss_2/users_grad/strided_sliceStridedSlice#gradients_1/loss_2/users_grad/Shape1gradients_1/loss_2/users_grad/strided_slice/stack3gradients_1/loss_2/users_grad/strided_slice/stack_13gradients_1/loss_2/users_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
:*
T0*
end_mask
k
)gradients_1/loss_2/users_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients_1/loss_2/users_grad/concatConcatV2(gradients_1/loss_2/users_grad/ExpandDims+gradients_1/loss_2/users_grad/strided_slice)gradients_1/loss_2/users_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
%gradients_1/loss_2/users_grad/ReshapeReshapegradients_1/AddN_2$gradients_1/loss_2/users_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
'gradients_1/loss_2/users_grad/Reshape_1Reshapeplaceholders_1/sampled_users(gradients_1/loss_2/users_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
q
!gradients_1/loss_2/sub_grad/ShapeShapeloss_2/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_1/loss_2/sub_grad/Shape_1Shapeloss_2/neg_items*
_output_shapes
:*
T0*
out_type0
�
1gradients_1/loss_2/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/sub_grad/Shape#gradients_1/loss_2/sub_grad/Shape_1*2
_output_shapes 
:���������:���������*
T0
�
gradients_1/loss_2/sub_grad/SumSum6gradients_1/loss_2/mul_grad/tuple/control_dependency_11gradients_1/loss_2/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
�
#gradients_1/loss_2/sub_grad/ReshapeReshapegradients_1/loss_2/sub_grad/Sum!gradients_1/loss_2/sub_grad/Shape*'
_output_shapes
:���������
*
T0*
Tshape0
�
!gradients_1/loss_2/sub_grad/Sum_1Sum6gradients_1/loss_2/mul_grad/tuple/control_dependency_13gradients_1/loss_2/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
l
gradients_1/loss_2/sub_grad/NegNeg!gradients_1/loss_2/sub_grad/Sum_1*
_output_shapes
:*
T0
�
%gradients_1/loss_2/sub_grad/Reshape_1Reshapegradients_1/loss_2/sub_grad/Neg#gradients_1/loss_2/sub_grad/Shape_1*'
_output_shapes
:���������
*
T0*
Tshape0
�
,gradients_1/loss_2/sub_grad/tuple/group_depsNoOp$^gradients_1/loss_2/sub_grad/Reshape&^gradients_1/loss_2/sub_grad/Reshape_1
�
4gradients_1/loss_2/sub_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/sub_grad/Reshape-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*6
_class,
*(loc:@gradients_1/loss_2/sub_grad/Reshape
�
6gradients_1/loss_2/sub_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/sub_grad/Reshape_1-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:���������
*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_grad/Reshape_1
�
gradients_1/AddN_3AddN6gradients_1/loss_2/pow_1_grad/tuple/control_dependency4gradients_1/loss_2/sub_grad/tuple/control_dependency*'
_output_shapes
:���������
*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape*
T0
�
'gradients_1/loss_2/pos_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *+
_class!
loc:@variables_1/item_factors
�
&gradients_1/loss_2/pos_items_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/pos_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/pos_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/pos_items_grad/Size0gradients_1/loss_2/pos_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients_1/loss_2/pos_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients_1/loss_2/pos_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/pos_items_grad/Shape5gradients_1/loss_2/pos_items_grad/strided_slice/stack7gradients_1/loss_2/pos_items_grad/strided_slice/stack_17gradients_1/loss_2/pos_items_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
:*
T0*
end_mask
o
-gradients_1/loss_2/pos_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients_1/loss_2/pos_items_grad/concatConcatV2,gradients_1/loss_2/pos_items_grad/ExpandDims/gradients_1/loss_2/pos_items_grad/strided_slice-gradients_1/loss_2/pos_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients_1/loss_2/pos_items_grad/ReshapeReshapegradients_1/AddN_3(gradients_1/loss_2/pos_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
+gradients_1/loss_2/pos_items_grad/Reshape_1Reshape placeholders_1/sampled_pos_items,gradients_1/loss_2/pos_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
�
gradients_1/AddN_4AddN6gradients_1/loss_2/pow_3_grad/tuple/control_dependency6gradients_1/loss_2/sub_grad/tuple/control_dependency_1*'
_output_shapes
:���������
*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape*
T0
�
'gradients_1/loss_2/neg_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *+
_class!
loc:@variables_1/item_factors
�
&gradients_1/loss_2/neg_items_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/neg_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients_1/loss_2/neg_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/neg_items_grad/Size0gradients_1/loss_2/neg_items_grad/ExpandDims/dim*
_output_shapes
:*
T0*

Tdim0

5gradients_1/loss_2/neg_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients_1/loss_2/neg_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/neg_items_grad/Shape5gradients_1/loss_2/neg_items_grad/strided_slice/stack7gradients_1/loss_2/neg_items_grad/strided_slice/stack_17gradients_1/loss_2/neg_items_grad/strided_slice/stack_2*
ellipsis_mask *
Index0*
shrink_axis_mask *

begin_mask *
new_axis_mask *
_output_shapes
:*
T0*
end_mask
o
-gradients_1/loss_2/neg_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients_1/loss_2/neg_items_grad/concatConcatV2,gradients_1/loss_2/neg_items_grad/ExpandDims/gradients_1/loss_2/neg_items_grad/strided_slice-gradients_1/loss_2/neg_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
�
)gradients_1/loss_2/neg_items_grad/ReshapeReshapegradients_1/AddN_4(gradients_1/loss_2/neg_items_grad/concat*0
_output_shapes
:������������������*
T0*
Tshape0
�
+gradients_1/loss_2/neg_items_grad/Reshape_1Reshape placeholders_1/sampled_neg_items,gradients_1/loss_2/neg_items_grad/ExpandDims*#
_output_shapes
:���������*
T0*
Tshape0
[
gradients_1/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concat_2ConcatV2)gradients_1/loss_2/pos_items_grad/Reshape)gradients_1/loss_2/neg_items_grad/Reshapegradients_1/concat_2/axis*0
_output_shapes
:������������������*
N*

Tidx0*
T0
[
gradients_1/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients_1/concat_3ConcatV2+gradients_1/loss_2/pos_items_grad/Reshape_1+gradients_1/loss_2/neg_items_grad/Reshape_1gradients_1/concat_3/axis*#
_output_shapes
:���������*
N*

Tidx0*
T0
d
GradientDescent_1/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *���=
�
5GradientDescent_1/update_variables_1/user_factors/mulMul%gradients_1/loss_2/users_grad/ReshapeGradientDescent_1/learning_rate*0
_output_shapes
:������������������*
T0*+
_class!
loc:@variables_1/user_factors
�
<GradientDescent_1/update_variables_1/user_factors/ScatterSub
ScatterSubvariables_1/user_factors'gradients_1/loss_2/users_grad/Reshape_15GradientDescent_1/update_variables_1/user_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *+
_class!
loc:@variables_1/user_factors
�
5GradientDescent_1/update_variables_1/item_factors/mulMulgradients_1/concat_2GradientDescent_1/learning_rate*0
_output_shapes
:������������������*
T0*+
_class!
loc:@variables_1/item_factors
�
<GradientDescent_1/update_variables_1/item_factors/ScatterSub
ScatterSubvariables_1/item_factorsgradients_1/concat_35GradientDescent_1/update_variables_1/item_factors/mul*
_output_shapes
:	�
*
T0*
Tindices0*
use_locking( *+
_class!
loc:@variables_1/item_factors
�
2GradientDescent_1/update_variables_1/item_bias/mulMulgradients_1/concatGradientDescent_1/learning_rate*#
_output_shapes
:���������*
T0*(
_class
loc:@variables_1/item_bias
�
9GradientDescent_1/update_variables_1/item_bias/ScatterSub
ScatterSubvariables_1/item_biasgradients_1/concat_12GradientDescent_1/update_variables_1/item_bias/mul*
_output_shapes	
:�*
T0*
Tindices0*
use_locking( *(
_class
loc:@variables_1/item_bias
�
GradientDescent_1NoOp=^GradientDescent_1/update_variables_1/user_factors/ScatterSub=^GradientDescent_1/update_variables_1/item_factors/ScatterSub:^GradientDescent_1/update_variables_1/item_bias/ScatterSub
R
loss_3/tagsConst*
_output_shapes
: *
dtype0*
valueB Bloss_3
S
loss_3ScalarSummaryloss_3/tagsloss_2/sub_2*
_output_shapes
: *
T0
U
Merge_1/MergeSummaryMergeSummaryloss_1loss_3*
_output_shapes
: *
N
�
init_1NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign""�
	variables��
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
variables_1/item_bias:0variables_1/item_bias/Assignvariables_1/item_bias/read:0"2
train_op&
$
GradientDescent
GradientDescent_1"�
trainable_variables��
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
variables_1/item_bias:0variables_1/item_bias/Assignvariables_1/item_bias/read:0"#
	summaries

loss_1:0
loss_3:0Hl�`