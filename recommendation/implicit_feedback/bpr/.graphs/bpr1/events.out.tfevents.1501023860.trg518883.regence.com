       £K"	   Эу]÷Abrain.Event:2йдa2     v"G	Ѓ-ґЬу]÷A"•Ь
h
placeholders/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
l
placeholders/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
l
placeholders/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
q
 variables/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
d
variables/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
f
!variables/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
≥
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
Ю
variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	д
*
T0
М
variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	д
*
T0
s
"variables/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
§
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Т
variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
М
variables/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
ў
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*)
_class
loc:@variables/user_factors
Ф
variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	д
*
T0*)
_class
loc:@variables/user_factors
М
variables/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
џ
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*)
_class
loc:@variables/item_factors
Ф
variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	з
*
T0*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Б
variables/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
Ѕ
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*&
_class
loc:@variables/item_bias
З
variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:з*
T0*&
_class
loc:@variables/item_bias
≠

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
µ
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
µ
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
≤
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
≤
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:€€€€€€€€€
*
T0
\
loss/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
А
loss/SumSumloss/mulloss/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:€€€€€€€€€*
T0
O
loss/SigmoidSigmoidloss/add*#
_output_shapes
:€€€€€€€€€*
T0
a
loss/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0

loss/clip_by_value/MinimumMinimumloss/Sigmoidloss/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Y
loss/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
}
loss/clip_by_valueMaximumloss/clip_by_value/Minimumloss/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
Q
loss/LogLogloss/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
T

loss/ConstConst*
valueB: *
_output_shapes
:*
dtype0
e

loss/Sum_1Sumloss/Log
loss/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
O

loss/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
Y
loss/powPow
loss/users
loss/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
]
loss/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
g

loss/Sum_2Sumloss/powloss/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
_output_shapes
: *
T0
Q
loss/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
]
loss/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
_output_shapes
: *
T0
Q
loss/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
V
loss/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
J

loss/add_1Add
loss/mul_2
loss/Sum_4*
_output_shapes
: *
T0
Q
loss/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
]
loss/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
_output_shapes
: *
T0
Q
loss/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
V
loss/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
J

loss/add_2Add
loss/mul_3
loss/Sum_6*
_output_shapes
: *
T0
J

loss/add_3Add
loss/mul_1
loss/add_1*
_output_shapes
: *
T0
J

loss/add_4Add
loss/add_3
loss/add_2*
_output_shapes
: *
T0
J

loss/sub_2Sub
loss/add_4
loss/Sum_1*
_output_shapes
: *
T0
R
gradients/ShapeConst*
valueB *
_output_shapes
: *
dtype0
T
gradients/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
Y
gradients/FillFillgradients/Shapegradients/Const*
_output_shapes
: *
T0
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
•
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
©
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Я
#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
е
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
л
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
…
gradients/loss/add_4_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Ќ
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
е
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
л
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
Њ
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
g
gradients/loss/Sum_1_grad/ShapeShapeloss/Log*
_output_shapes
:*
T0*
out_type0
™
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
…
gradients/loss/add_3_grad/SumSum2gradients/loss/add_4_grad/tuple/control_dependency/gradients/loss/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Ќ
gradients/loss/add_3_grad/Sum_1Sum2gradients/loss/add_4_grad/tuple/control_dependency1gradients/loss/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
е
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
л
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ћ
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ѕ
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
е
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
л
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1
У
"gradients/loss/Log_grad/Reciprocal
Reciprocalloss/clip_by_value^gradients/loss/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
Ф
gradients/loss/Log_grad/mulMulgradients/loss/Sum_1_grad/Tile"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Е
gradients/loss/mul_1_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
і
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Й
gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
Ї
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
е
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
л
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ћ
gradients/loss/add_1_grad/SumSum4gradients/loss/add_3_grad/tuple/control_dependency_1/gradients/loss/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ѕ
gradients/loss/add_1_grad/Sum_1Sum4gradients/loss/add_3_grad/tuple/control_dependency_11gradients/loss/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
е
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
л
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Е
gradients/loss/mul_3_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
і
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Й
gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
Ї
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
е
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
л
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
Њ
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
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
™
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
Б
'gradients/loss/clip_by_value_grad/ShapeShapeloss/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
l
)gradients/loss/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Д
)gradients/loss/clip_by_value_grad/Shape_2Shapegradients/loss/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
r
-gradients/loss/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
Ј
'gradients/loss/clip_by_value_grad/zerosFill)gradients/loss/clip_by_value_grad/Shape_2-gradients/loss/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ю
.gradients/loss/clip_by_value_grad/GreaterEqualGreaterEqualloss/clip_by_value/Minimumloss/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
б
7gradients/loss/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs'gradients/loss/clip_by_value_grad/Shape)gradients/loss/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
÷
(gradients/loss/clip_by_value_grad/SelectSelect.gradients/loss/clip_by_value_grad/GreaterEqualgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
П
,gradients/loss/clip_by_value_grad/LogicalNot
LogicalNot.gradients/loss/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
÷
*gradients/loss/clip_by_value_grad/Select_1Select,gradients/loss/clip_by_value_grad/LogicalNotgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
ѕ
%gradients/loss/clip_by_value_grad/SumSum(gradients/loss/clip_by_value_grad/Select7gradients/loss/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ј
)gradients/loss/clip_by_value_grad/ReshapeReshape%gradients/loss/clip_by_value_grad/Sum'gradients/loss/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
’
'gradients/loss/clip_by_value_grad/Sum_1Sum*gradients/loss/clip_by_value_grad/Select_19gradients/loss/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
є
+gradients/loss/clip_by_value_grad/Reshape_1Reshape'gradients/loss/clip_by_value_grad/Sum_1)gradients/loss/clip_by_value_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
Ф
2gradients/loss/clip_by_value_grad/tuple/group_depsNoOp*^gradients/loss/clip_by_value_grad/Reshape,^gradients/loss/clip_by_value_grad/Reshape_1
Т
:gradients/loss/clip_by_value_grad/tuple/control_dependencyIdentity)gradients/loss/clip_by_value_grad/Reshape3^gradients/loss/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*<
_class2
0.loc:@gradients/loss/clip_by_value_grad/Reshape
Л
<gradients/loss/clip_by_value_grad/tuple/control_dependency_1Identity+gradients/loss/clip_by_value_grad/Reshape_13^gradients/loss/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*>
_class4
20loc:@gradients/loss/clip_by_value_grad/Reshape_1
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
¬
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
Ѓ
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Е
gradients/loss/mul_2_grad/mulMul2gradients/loss/add_1_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
і
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Й
gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
Ї
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
е
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
л
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
Њ
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_1_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
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
™
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
¬
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
Ѓ
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
А
gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Т
gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
ґ
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
ј
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
А
gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
Ч
gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
Ї
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
т
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
л
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1
{
/gradients/loss/clip_by_value/Minimum_grad/ShapeShapeloss/Sigmoid*
_output_shapes
:*
T0*
out_type0
t
1gradients/loss/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Ђ
1gradients/loss/clip_by_value/Minimum_grad/Shape_2Shape:gradients/loss/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
z
5gradients/loss/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
ѕ
/gradients/loss/clip_by_value/Minimum_grad/zerosFill1gradients/loss/clip_by_value/Minimum_grad/Shape_25gradients/loss/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ъ
3gradients/loss/clip_by_value/Minimum_grad/LessEqual	LessEqualloss/Sigmoidloss/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
щ
?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs/gradients/loss/clip_by_value/Minimum_grad/Shape1gradients/loss/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
0gradients/loss/clip_by_value/Minimum_grad/SelectSelect3gradients/loss/clip_by_value/Minimum_grad/LessEqual:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ь
4gradients/loss/clip_by_value/Minimum_grad/LogicalNot
LogicalNot3gradients/loss/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Н
2gradients/loss/clip_by_value/Minimum_grad/Select_1Select4gradients/loss/clip_by_value/Minimum_grad/LogicalNot:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
з
-gradients/loss/clip_by_value/Minimum_grad/SumSum0gradients/loss/clip_by_value/Minimum_grad/Select?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ў
1gradients/loss/clip_by_value/Minimum_grad/ReshapeReshape-gradients/loss/clip_by_value/Minimum_grad/Sum/gradients/loss/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
н
/gradients/loss/clip_by_value/Minimum_grad/Sum_1Sum2gradients/loss/clip_by_value/Minimum_grad/Select_1Agradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
—
3gradients/loss/clip_by_value/Minimum_grad/Reshape_1Reshape/gradients/loss/clip_by_value/Minimum_grad/Sum_11gradients/loss/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
ђ
:gradients/loss/clip_by_value/Minimum_grad/tuple/group_depsNoOp2^gradients/loss/clip_by_value/Minimum_grad/Reshape4^gradients/loss/clip_by_value/Minimum_grad/Reshape_1
≤
Bgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity1gradients/loss/clip_by_value/Minimum_grad/Reshape;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*D
_class:
86loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape
Ђ
Dgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity3gradients/loss/clip_by_value/Minimum_grad/Reshape_1;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*F
_class<
:8loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape_1
g
gradients/loss/pow_grad/ShapeShape
loss/users*
_output_shapes
:*
T0*
out_type0
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
√
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
А
gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
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
:€€€€€€€€€
*
T0
Р
gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
∞
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
¶
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Л
gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:€€€€€€€€€
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
А
gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:€€€€€€€€€
*
T0
Х
gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
і
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
о
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
г
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
¬
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
Ѓ
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
А
gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Т
gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
ґ
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
ј
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
А
gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
Ч
gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
Ї
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
т
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
л
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
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Д
gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ц
gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
ґ
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ђ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
ƒ
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
Д
gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
Ы
gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
ц
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
л
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1
ґ
'gradients/loss/Sigmoid_grad/SigmoidGradSigmoidGradloss/SigmoidBgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Д
gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ц
gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
ґ
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ђ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
ƒ
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
Д
gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
Ы
gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
ц
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
л
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
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
√
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ї
gradients/loss/add_grad/SumSum'gradients/loss/Sigmoid_grad/SigmoidGrad-gradients/loss/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ґ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
Њ
gradients/loss/add_grad/Sum_1Sum'gradients/loss/Sigmoid_grad/SigmoidGrad/gradients/loss/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
к
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
р
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
…
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
«
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
Ћ
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
_output_shapes
:*
T0
ђ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
т
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
ш
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
gradients/loss/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
Г
gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
ґ
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
К
gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
ж
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
N*
T0
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ґ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
С
 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
ґ
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
Ђ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
л
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
N*
T0*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
Ъ
'gradients/loss/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*&
_class
loc:@variables/item_bias

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
•
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
™
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
ј
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
п
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
N*
T0*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
Ъ
'gradients/loss/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*&
_class
loc:@variables/item_bias

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
•
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ђ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
ј
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
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
√
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ѓ
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
¶
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
А
gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
і
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ђ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
о
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
ф
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1
W
gradients/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ћ
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
Y
gradients/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
‘
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
л
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
Ы
gradients/loss/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*)
_class
loc:@variables/user_factors
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
_output_shapes
: *
T0*
out_type0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≠
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
€
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
№
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
©
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
ђ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
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
√
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
≈
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
¶
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
…
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
_output_shapes
:*
T0
™
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
о
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
ф
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
п
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
Я
#gradients/loss/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*)
_class
loc:@variables/item_factors
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
±
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
Є
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
с
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
N*
T0*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
Я
#gradients/loss/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*)
_class
loc:@variables/item_factors
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
±
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
Є
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
Y
gradients/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
’
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
N*
T0*

Tidx0
Y
gradients/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
ћ
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
b
GradientDescent/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
а
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*)
_class
loc:@variables/user_factors
Ѓ
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*)
_class
loc:@variables/user_factors
—
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*)
_class
loc:@variables/item_factors
Э
8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*)
_class
loc:@variables/item_factors
Љ
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*&
_class
loc:@variables/item_bias
Н
5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*&
_class
loc:@variables/item_bias
≈
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
_output_shapes
: *
dtype0
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
placeholders_1/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_1/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_1/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_1/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_1/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_1/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_1/truncated_normal/TruncatedNormalTruncatedNormal"variables_1/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_1/truncated_normal/mulMul,variables_1/truncated_normal/TruncatedNormal#variables_1/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_1/truncated_normalAdd variables_1/truncated_normal/mul!variables_1/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_1/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_1/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_1/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_1/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_1/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_1/truncated_normal_1/mulMul.variables_1/truncated_normal_1/TruncatedNormal%variables_1/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_1/truncated_normal_1Add"variables_1/truncated_normal_1/mul#variables_1/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_1/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_1/user_factors/AssignAssignvariables_1/user_factorsvariables_1/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_1/user_factors
Ъ
variables_1/user_factors/readIdentityvariables_1/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_1/user_factors
О
variables_1/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_1/item_factors/AssignAssignvariables_1/item_factorsvariables_1/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_1/item_factors
Ъ
variables_1/item_factors/readIdentityvariables_1/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_1/item_factors
`
variables_1/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_1/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_1/item_bias/AssignAssignvariables_1/item_biasvariables_1/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_1/item_bias
Н
variables_1/item_bias/readIdentityvariables_1/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_1/item_bias
≥
loss_2/usersGathervariables_1/user_factors/readplaceholders_1/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_2/pos_itemsGathervariables_1/item_factors/read placeholders_1/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_2/neg_itemsGathervariables_1/item_factors/read placeholders_1/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_2/pos_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_2/neg_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_2/subSubloss_2/pos_itemsloss_2/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_2/mulMulloss_2/users
loss_2/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_2/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_2/SumSum
loss_2/mulloss_2/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_2/sub_1Subloss_2/pos_item_biasloss_2/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_2/addAddloss_2/sub_1
loss_2/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_2/SigmoidSigmoid
loss_2/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_2/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_2/clip_by_value/MinimumMinimumloss_2/Sigmoidloss_2/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_2/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_2/clip_by_valueMaximumloss_2/clip_by_value/Minimumloss_2/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_2/LogLogloss_2/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_2/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_2/Sum_1Sum
loss_2/Logloss_2/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_2/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_2/powPowloss_2/usersloss_2/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_2/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_2/Sum_2Sum
loss_2/powloss_2/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_2/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_2/mul_1Mulloss_2/mul_1/xloss_2/Sum_2*
_output_shapes
: *
T0
S
loss_2/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_1Powloss_2/pos_itemsloss_2/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_2/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_2/Sum_3Sumloss_2/pow_1loss_2/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_2/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_2/mul_2Mulloss_2/mul_2/xloss_2/Sum_3*
_output_shapes
: *
T0
S
loss_2/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_2Powloss_2/pos_item_biasloss_2/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_2/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_2/Sum_4Sumloss_2/pow_2loss_2/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_2/add_1Addloss_2/mul_2loss_2/Sum_4*
_output_shapes
: *
T0
S
loss_2/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_3Powloss_2/neg_itemsloss_2/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_2/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_2/Sum_5Sumloss_2/pow_3loss_2/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_2/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_2/mul_3Mulloss_2/mul_3/xloss_2/Sum_5*
_output_shapes
: *
T0
S
loss_2/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_4Powloss_2/neg_item_biasloss_2/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_2/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_2/Sum_6Sumloss_2/pow_4loss_2/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_2/add_2Addloss_2/mul_3loss_2/Sum_6*
_output_shapes
: *
T0
P
loss_2/add_3Addloss_2/mul_1loss_2/add_1*
_output_shapes
: *
T0
P
loss_2/add_4Addloss_2/add_3loss_2/add_2*
_output_shapes
: *
T0
P
loss_2/sub_2Subloss_2/add_4loss_2/Sum_1*
_output_shapes
: *
T0
T
gradients_1/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_1/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_1/FillFillgradients_1/Shapegradients_1/Const*
_output_shapes
: *
T0
f
#gradients_1/loss_2/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_2_grad/Shape%gradients_1/loss_2/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_1/loss_2/sub_2_grad/SumSumgradients_1/Fill3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/sub_2_grad/ReshapeReshape!gradients_1/loss_2/sub_2_grad/Sum#gradients_1/loss_2/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
≥
#gradients_1/loss_2/sub_2_grad/Sum_1Sumgradients_1/Fill5gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_1/loss_2/sub_2_grad/NegNeg#gradients_1/loss_2/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_1/loss_2/sub_2_grad/Reshape_1Reshape!gradients_1/loss_2/sub_2_grad/Neg%gradients_1/loss_2/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/sub_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_2_grad/Reshape(^gradients_1/loss_2/sub_2_grad/Reshape_1
х
6gradients_1/loss_2/sub_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_2_grad/Reshape/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_2_grad/Reshape
ы
8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_2_grad/Reshape_1/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/sub_2_grad/Reshape_1
f
#gradients_1/loss_2/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_4_grad/Shape%gradients_1/loss_2/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_1/loss_2/add_4_grad/SumSum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency3gradients_1/loss_2/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_4_grad/ReshapeReshape!gradients_1/loss_2/add_4_grad/Sum#gradients_1/loss_2/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_1/loss_2/add_4_grad/Sum_1Sum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency5gradients_1/loss_2/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_4_grad/Reshape_1Reshape#gradients_1/loss_2/add_4_grad/Sum_1%gradients_1/loss_2/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/add_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_4_grad/Reshape(^gradients_1/loss_2/add_4_grad/Reshape_1
х
6gradients_1/loss_2/add_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_4_grad/Reshape/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_4_grad/Reshape
ы
8gradients_1/loss_2/add_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_4_grad/Reshape_1/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_4_grad/Reshape_1
u
+gradients_1/loss_2/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_1/loss_2/Sum_1_grad/ReshapeReshape8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
m
#gradients_1/loss_2/Sum_1_grad/ShapeShape
loss_2/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_1/loss_2/Sum_1_grad/TileTile%gradients_1/loss_2/Sum_1_grad/Reshape#gradients_1/loss_2/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_1/loss_2/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_3_grad/Shape%gradients_1/loss_2/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_1/loss_2/add_3_grad/SumSum6gradients_1/loss_2/add_4_grad/tuple/control_dependency3gradients_1/loss_2/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_3_grad/ReshapeReshape!gradients_1/loss_2/add_3_grad/Sum#gradients_1/loss_2/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_1/loss_2/add_3_grad/Sum_1Sum6gradients_1/loss_2/add_4_grad/tuple/control_dependency5gradients_1/loss_2/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_3_grad/Reshape_1Reshape#gradients_1/loss_2/add_3_grad/Sum_1%gradients_1/loss_2/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/add_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_3_grad/Reshape(^gradients_1/loss_2/add_3_grad/Reshape_1
х
6gradients_1/loss_2/add_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_3_grad/Reshape/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_3_grad/Reshape
ы
8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_3_grad/Reshape_1/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_3_grad/Reshape_1
f
#gradients_1/loss_2/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_2_grad/Shape%gradients_1/loss_2/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_1/loss_2/add_2_grad/SumSum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_13gradients_1/loss_2/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_2_grad/ReshapeReshape!gradients_1/loss_2/add_2_grad/Sum#gradients_1/loss_2/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_1/loss_2/add_2_grad/Sum_1Sum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_15gradients_1/loss_2/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_2_grad/Reshape_1Reshape#gradients_1/loss_2/add_2_grad/Sum_1%gradients_1/loss_2/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/add_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_2_grad/Reshape(^gradients_1/loss_2/add_2_grad/Reshape_1
х
6gradients_1/loss_2/add_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_2_grad/Reshape/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_2_grad/Reshape
ы
8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_2_grad/Reshape_1/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_2_grad/Reshape_1
Э
&gradients_1/loss_2/Log_grad/Reciprocal
Reciprocalloss_2/clip_by_value#^gradients_1/loss_2/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_1/loss_2/Log_grad/mulMul"gradients_1/loss_2/Sum_1_grad/Tile&gradients_1/loss_2/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_1/loss_2/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_1_grad/Shape%gradients_1/loss_2/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_1/loss_2/mul_1_grad/mulMul6gradients_1/loss_2/add_3_grad/tuple/control_dependencyloss_2/Sum_2*
_output_shapes
: *
T0
ј
!gradients_1/loss_2/mul_1_grad/SumSum!gradients_1/loss_2/mul_1_grad/mul3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/mul_1_grad/ReshapeReshape!gradients_1/loss_2/mul_1_grad/Sum#gradients_1/loss_2/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_1/loss_2/mul_1_grad/mul_1Mulloss_2/mul_1/x6gradients_1/loss_2/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_1/loss_2/mul_1_grad/Sum_1Sum#gradients_1/loss_2/mul_1_grad/mul_15gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/mul_1_grad/Reshape_1Reshape#gradients_1/loss_2/mul_1_grad/Sum_1%gradients_1/loss_2/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/mul_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_1_grad/Reshape(^gradients_1/loss_2/mul_1_grad/Reshape_1
х
6gradients_1/loss_2/mul_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_1_grad/Reshape/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_1_grad/Reshape
ы
8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_1_grad/Reshape_1/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_1_grad/Reshape_1
f
#gradients_1/loss_2/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_1_grad/Shape%gradients_1/loss_2/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_1/loss_2/add_1_grad/SumSum8gradients_1/loss_2/add_3_grad/tuple/control_dependency_13gradients_1/loss_2/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_1_grad/ReshapeReshape!gradients_1/loss_2/add_1_grad/Sum#gradients_1/loss_2/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_1/loss_2/add_1_grad/Sum_1Sum8gradients_1/loss_2/add_3_grad/tuple/control_dependency_15gradients_1/loss_2/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_1_grad/Reshape_1Reshape#gradients_1/loss_2/add_1_grad/Sum_1%gradients_1/loss_2/add_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/add_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_1_grad/Reshape(^gradients_1/loss_2/add_1_grad/Reshape_1
х
6gradients_1/loss_2/add_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_1_grad/Reshape/^gradients_1/loss_2/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_1_grad/Reshape
ы
8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_1_grad/Reshape_1/^gradients_1/loss_2/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_1_grad/Reshape_1
f
#gradients_1/loss_2/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_3_grad/Shape%gradients_1/loss_2/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_1/loss_2/mul_3_grad/mulMul6gradients_1/loss_2/add_2_grad/tuple/control_dependencyloss_2/Sum_5*
_output_shapes
: *
T0
ј
!gradients_1/loss_2/mul_3_grad/SumSum!gradients_1/loss_2/mul_3_grad/mul3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/mul_3_grad/ReshapeReshape!gradients_1/loss_2/mul_3_grad/Sum#gradients_1/loss_2/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_1/loss_2/mul_3_grad/mul_1Mulloss_2/mul_3/x6gradients_1/loss_2/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_1/loss_2/mul_3_grad/Sum_1Sum#gradients_1/loss_2/mul_3_grad/mul_15gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/mul_3_grad/Reshape_1Reshape#gradients_1/loss_2/mul_3_grad/Sum_1%gradients_1/loss_2/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/mul_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_3_grad/Reshape(^gradients_1/loss_2/mul_3_grad/Reshape_1
х
6gradients_1/loss_2/mul_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_3_grad/Reshape/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_3_grad/Reshape
ы
8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_3_grad/Reshape_1/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_3_grad/Reshape_1
u
+gradients_1/loss_2/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_1/loss_2/Sum_6_grad/ReshapeReshape8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_6_grad/Reshape/shape*
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
ґ
"gradients_1/loss_2/Sum_6_grad/TileTile%gradients_1/loss_2/Sum_6_grad/Reshape#gradients_1/loss_2/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_1/loss_2/clip_by_value_grad/ShapeShapeloss_2/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_1/loss_2/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_1/loss_2/clip_by_value_grad/Shape_2Shapegradients_1/loss_2/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_1/loss_2/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_1/loss_2/clip_by_value_grad/zerosFill-gradients_1/loss_2/clip_by_value_grad/Shape_21gradients_1/loss_2/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_1/loss_2/clip_by_value_grad/GreaterEqualGreaterEqualloss_2/clip_by_value/Minimumloss_2/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_1/loss_2/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_1/loss_2/clip_by_value_grad/Shape-gradients_1/loss_2/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_1/loss_2/clip_by_value_grad/SelectSelect2gradients_1/loss_2/clip_by_value_grad/GreaterEqualgradients_1/loss_2/Log_grad/mul+gradients_1/loss_2/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_1/loss_2/clip_by_value_grad/LogicalNot
LogicalNot2gradients_1/loss_2/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_1/loss_2/clip_by_value_grad/Select_1Select0gradients_1/loss_2/clip_by_value_grad/LogicalNotgradients_1/loss_2/Log_grad/mul+gradients_1/loss_2/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_1/loss_2/clip_by_value_grad/SumSum,gradients_1/loss_2/clip_by_value_grad/Select;gradients_1/loss_2/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_1/loss_2/clip_by_value_grad/ReshapeReshape)gradients_1/loss_2/clip_by_value_grad/Sum+gradients_1/loss_2/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
б
+gradients_1/loss_2/clip_by_value_grad/Sum_1Sum.gradients_1/loss_2/clip_by_value_grad/Select_1=gradients_1/loss_2/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_1/loss_2/clip_by_value_grad/Reshape_1Reshape+gradients_1/loss_2/clip_by_value_grad/Sum_1-gradients_1/loss_2/clip_by_value_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
†
6gradients_1/loss_2/clip_by_value_grad/tuple/group_depsNoOp.^gradients_1/loss_2/clip_by_value_grad/Reshape0^gradients_1/loss_2/clip_by_value_grad/Reshape_1
Ґ
>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_1/loss_2/clip_by_value_grad/Reshape7^gradients_1/loss_2/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_1/loss_2/clip_by_value_grad/Reshape
Ы
@gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_1/loss_2/clip_by_value_grad/Reshape_17^gradients_1/loss_2/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_1/loss_2/clip_by_value_grad/Reshape_1
|
+gradients_1/loss_2/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
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
Ї
"gradients_1/loss_2/Sum_2_grad/TileTile%gradients_1/loss_2/Sum_2_grad/Reshape#gradients_1/loss_2/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_1/loss_2/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_2_grad/Shape%gradients_1/loss_2/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_1/loss_2/mul_2_grad/mulMul6gradients_1/loss_2/add_1_grad/tuple/control_dependencyloss_2/Sum_3*
_output_shapes
: *
T0
ј
!gradients_1/loss_2/mul_2_grad/SumSum!gradients_1/loss_2/mul_2_grad/mul3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/mul_2_grad/ReshapeReshape!gradients_1/loss_2/mul_2_grad/Sum#gradients_1/loss_2/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_1/loss_2/mul_2_grad/mul_1Mulloss_2/mul_2/x6gradients_1/loss_2/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_1/loss_2/mul_2_grad/Sum_1Sum#gradients_1/loss_2/mul_2_grad/mul_15gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/mul_2_grad/Reshape_1Reshape#gradients_1/loss_2/mul_2_grad/Sum_1%gradients_1/loss_2/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/mul_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_2_grad/Reshape(^gradients_1/loss_2/mul_2_grad/Reshape_1
х
6gradients_1/loss_2/mul_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_2_grad/Reshape/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_2_grad/Reshape
ы
8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_2_grad/Reshape_1/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_2_grad/Reshape_1
u
+gradients_1/loss_2/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_1/loss_2/Sum_4_grad/ReshapeReshape8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_4_grad/Reshape/shape*
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
ґ
"gradients_1/loss_2/Sum_4_grad/TileTile%gradients_1/loss_2/Sum_4_grad/Reshape#gradients_1/loss_2/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_1/loss_2/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
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
Ї
"gradients_1/loss_2/Sum_5_grad/TileTile%gradients_1/loss_2/Sum_5_grad/Reshape#gradients_1/loss_2/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_1/loss_2/pow_4_grad/ShapeShapeloss_2/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_4_grad/Shape%gradients_1/loss_2/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_1/loss_2/pow_4_grad/mulMul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_1/loss_2/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_4_grad/subSubloss_2/pow_4/y#gradients_1/loss_2/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_4_grad/PowPowloss_2/neg_item_bias!gradients_1/loss_2/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_1/loss_2/pow_4_grad/mul_1Mul!gradients_1/loss_2/pow_4_grad/mul!gradients_1/loss_2/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_1/loss_2/pow_4_grad/SumSum#gradients_1/loss_2/pow_4_grad/mul_13gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/pow_4_grad/ReshapeReshape!gradients_1/loss_2/pow_4_grad/Sum#gradients_1/loss_2/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_1/loss_2/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_4_grad/GreaterGreaterloss_2/neg_item_bias'gradients_1/loss_2/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_1/loss_2/pow_4_grad/LogLogloss_2/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_1/loss_2/pow_4_grad/zeros_like	ZerosLikeloss_2/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_1/loss_2/pow_4_grad/SelectSelect%gradients_1/loss_2/pow_4_grad/Greater!gradients_1/loss_2/pow_4_grad/Log(gradients_1/loss_2/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_1/loss_2/pow_4_grad/mul_2Mul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_1/loss_2/pow_4_grad/mul_3Mul#gradients_1/loss_2/pow_4_grad/mul_2$gradients_1/loss_2/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_1/loss_2/pow_4_grad/Sum_1Sum#gradients_1/loss_2/pow_4_grad/mul_35gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_4_grad/Reshape_1Reshape#gradients_1/loss_2/pow_4_grad/Sum_1%gradients_1/loss_2/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/pow_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_4_grad/Reshape(^gradients_1/loss_2/pow_4_grad/Reshape_1
В
6gradients_1/loss_2/pow_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_4_grad/Reshape/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape
ы
8gradients_1/loss_2/pow_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_4_grad/Reshape_1/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_4_grad/Reshape_1
Б
3gradients_1/loss_2/clip_by_value/Minimum_grad/ShapeShapeloss_2/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_2Shape>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_1/loss_2/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_1/loss_2/clip_by_value/Minimum_grad/zerosFill5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_29gradients_1/loss_2/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_1/loss_2/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_2/Sigmoidloss_2/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_1/loss_2/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_1/loss_2/clip_by_value/Minimum_grad/Shape5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_1/loss_2/clip_by_value/Minimum_grad/SelectSelect7gradients_1/loss_2/clip_by_value/Minimum_grad/LessEqual>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency3gradients_1/loss_2/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_1/loss_2/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_1/loss_2/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_1/loss_2/clip_by_value/Minimum_grad/Select_1Select8gradients_1/loss_2/clip_by_value/Minimum_grad/LogicalNot>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency3gradients_1/loss_2/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_1/loss_2/clip_by_value/Minimum_grad/SumSum4gradients_1/loss_2/clip_by_value/Minimum_grad/SelectCgradients_1/loss_2/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_1/loss_2/clip_by_value/Minimum_grad/ReshapeReshape1gradients_1/loss_2/clip_by_value/Minimum_grad/Sum3gradients_1/loss_2/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
щ
3gradients_1/loss_2/clip_by_value/Minimum_grad/Sum_1Sum6gradients_1/loss_2/clip_by_value/Minimum_grad/Select_1Egradients_1/loss_2/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_1/loss_2/clip_by_value/Minimum_grad/Sum_15gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
Є
>gradients_1/loss_2/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape8^gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_1/loss_2/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape?^gradients_1/loss_2/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_1/loss_2/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1?^gradients_1/loss_2/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_1/loss_2/pow_grad/ShapeShapeloss_2/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_1/loss_2/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_1/loss_2/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/pow_grad/Shape#gradients_1/loss_2/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_1/loss_2/pow_grad/mulMul"gradients_1/loss_2/Sum_2_grad/Tileloss_2/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_1/loss_2/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_1/loss_2/pow_grad/subSubloss_2/pow/y!gradients_1/loss_2/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_1/loss_2/pow_grad/PowPowloss_2/usersgradients_1/loss_2/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_1/loss_2/pow_grad/mul_1Mulgradients_1/loss_2/pow_grad/mulgradients_1/loss_2/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_1/loss_2/pow_grad/SumSum!gradients_1/loss_2/pow_grad/mul_11gradients_1/loss_2/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_1/loss_2/pow_grad/ReshapeReshapegradients_1/loss_2/pow_grad/Sum!gradients_1/loss_2/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
j
%gradients_1/loss_2/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_1/loss_2/pow_grad/GreaterGreaterloss_2/users%gradients_1/loss_2/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_1/loss_2/pow_grad/LogLogloss_2/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_1/loss_2/pow_grad/zeros_like	ZerosLikeloss_2/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_1/loss_2/pow_grad/SelectSelect#gradients_1/loss_2/pow_grad/Greatergradients_1/loss_2/pow_grad/Log&gradients_1/loss_2/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_1/loss_2/pow_grad/mul_2Mul"gradients_1/loss_2/Sum_2_grad/Tile
loss_2/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_1/loss_2/pow_grad/mul_3Mul!gradients_1/loss_2/pow_grad/mul_2"gradients_1/loss_2/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_1/loss_2/pow_grad/Sum_1Sum!gradients_1/loss_2/pow_grad/mul_33gradients_1/loss_2/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/pow_grad/Reshape_1Reshape!gradients_1/loss_2/pow_grad/Sum_1#gradients_1/loss_2/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
В
,gradients_1/loss_2/pow_grad/tuple/group_depsNoOp$^gradients_1/loss_2/pow_grad/Reshape&^gradients_1/loss_2/pow_grad/Reshape_1
ю
4gradients_1/loss_2/pow_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/pow_grad/Reshape-^gradients_1/loss_2/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape
у
6gradients_1/loss_2/pow_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/pow_grad/Reshape_1-^gradients_1/loss_2/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_grad/Reshape_1
|
+gradients_1/loss_2/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
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
Ї
"gradients_1/loss_2/Sum_3_grad/TileTile%gradients_1/loss_2/Sum_3_grad/Reshape#gradients_1/loss_2/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_1/loss_2/pow_2_grad/ShapeShapeloss_2/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_2_grad/Shape%gradients_1/loss_2/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_1/loss_2/pow_2_grad/mulMul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_1/loss_2/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_2_grad/subSubloss_2/pow_2/y#gradients_1/loss_2/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_2_grad/PowPowloss_2/pos_item_bias!gradients_1/loss_2/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_1/loss_2/pow_2_grad/mul_1Mul!gradients_1/loss_2/pow_2_grad/mul!gradients_1/loss_2/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_1/loss_2/pow_2_grad/SumSum#gradients_1/loss_2/pow_2_grad/mul_13gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/pow_2_grad/ReshapeReshape!gradients_1/loss_2/pow_2_grad/Sum#gradients_1/loss_2/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_1/loss_2/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_2_grad/GreaterGreaterloss_2/pos_item_bias'gradients_1/loss_2/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_1/loss_2/pow_2_grad/LogLogloss_2/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_1/loss_2/pow_2_grad/zeros_like	ZerosLikeloss_2/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_1/loss_2/pow_2_grad/SelectSelect%gradients_1/loss_2/pow_2_grad/Greater!gradients_1/loss_2/pow_2_grad/Log(gradients_1/loss_2/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_1/loss_2/pow_2_grad/mul_2Mul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_1/loss_2/pow_2_grad/mul_3Mul#gradients_1/loss_2/pow_2_grad/mul_2$gradients_1/loss_2/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_1/loss_2/pow_2_grad/Sum_1Sum#gradients_1/loss_2/pow_2_grad/mul_35gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_2_grad/Reshape_1Reshape#gradients_1/loss_2/pow_2_grad/Sum_1%gradients_1/loss_2/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/pow_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_2_grad/Reshape(^gradients_1/loss_2/pow_2_grad/Reshape_1
В
6gradients_1/loss_2/pow_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_2_grad/Reshape/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape
ы
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
%gradients_1/loss_2/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_3_grad/Shape%gradients_1/loss_2/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_1/loss_2/pow_3_grad/mulMul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_1/loss_2/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_3_grad/subSubloss_2/pow_3/y#gradients_1/loss_2/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_3_grad/PowPowloss_2/neg_items!gradients_1/loss_2/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_1/loss_2/pow_3_grad/mul_1Mul!gradients_1/loss_2/pow_3_grad/mul!gradients_1/loss_2/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_1/loss_2/pow_3_grad/SumSum#gradients_1/loss_2/pow_3_grad/mul_13gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_1/loss_2/pow_3_grad/ReshapeReshape!gradients_1/loss_2/pow_3_grad/Sum#gradients_1/loss_2/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_1/loss_2/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_3_grad/GreaterGreaterloss_2/neg_items'gradients_1/loss_2/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_1/loss_2/pow_3_grad/LogLogloss_2/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_1/loss_2/pow_3_grad/zeros_like	ZerosLikeloss_2/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_1/loss_2/pow_3_grad/SelectSelect%gradients_1/loss_2/pow_3_grad/Greater!gradients_1/loss_2/pow_3_grad/Log(gradients_1/loss_2/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_1/loss_2/pow_3_grad/mul_2Mul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_1/loss_2/pow_3_grad/mul_3Mul#gradients_1/loss_2/pow_3_grad/mul_2$gradients_1/loss_2/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_1/loss_2/pow_3_grad/Sum_1Sum#gradients_1/loss_2/pow_3_grad/mul_35gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_3_grad/Reshape_1Reshape#gradients_1/loss_2/pow_3_grad/Sum_1%gradients_1/loss_2/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/pow_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_3_grad/Reshape(^gradients_1/loss_2/pow_3_grad/Reshape_1
Ж
6gradients_1/loss_2/pow_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_3_grad/Reshape/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape
ы
8gradients_1/loss_2/pow_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_3_grad/Reshape_1/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_3_grad/Reshape_1
ј
+gradients_1/loss_2/Sigmoid_grad/SigmoidGradSigmoidGradloss_2/SigmoidFgradients_1/loss_2/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_1/loss_2/pow_1_grad/ShapeShapeloss_2/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_1_grad/Shape%gradients_1/loss_2/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_1/loss_2/pow_1_grad/mulMul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_1/loss_2/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_1_grad/subSubloss_2/pow_1/y#gradients_1/loss_2/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_1_grad/PowPowloss_2/pos_items!gradients_1/loss_2/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_1/loss_2/pow_1_grad/mul_1Mul!gradients_1/loss_2/pow_1_grad/mul!gradients_1/loss_2/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_1/loss_2/pow_1_grad/SumSum#gradients_1/loss_2/pow_1_grad/mul_13gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_1/loss_2/pow_1_grad/ReshapeReshape!gradients_1/loss_2/pow_1_grad/Sum#gradients_1/loss_2/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_1/loss_2/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_1_grad/GreaterGreaterloss_2/pos_items'gradients_1/loss_2/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_1/loss_2/pow_1_grad/LogLogloss_2/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_1/loss_2/pow_1_grad/zeros_like	ZerosLikeloss_2/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_1/loss_2/pow_1_grad/SelectSelect%gradients_1/loss_2/pow_1_grad/Greater!gradients_1/loss_2/pow_1_grad/Log(gradients_1/loss_2/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_1/loss_2/pow_1_grad/mul_2Mul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_1/loss_2/pow_1_grad/mul_3Mul#gradients_1/loss_2/pow_1_grad/mul_2$gradients_1/loss_2/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_1/loss_2/pow_1_grad/Sum_1Sum#gradients_1/loss_2/pow_1_grad/mul_35gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_1_grad/Reshape_1Reshape#gradients_1/loss_2/pow_1_grad/Sum_1%gradients_1/loss_2/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_1/loss_2/pow_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_1_grad/Reshape(^gradients_1/loss_2/pow_1_grad/Reshape_1
Ж
6gradients_1/loss_2/pow_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_1_grad/Reshape/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape
ы
8gradients_1/loss_2/pow_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_1_grad/Reshape_1/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_1_grad/Reshape_1
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
ѕ
1gradients_1/loss_2/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/add_grad/Shape#gradients_1/loss_2/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_1/loss_2/add_grad/SumSum+gradients_1/loss_2/Sigmoid_grad/SigmoidGrad1gradients_1/loss_2/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_1/loss_2/add_grad/ReshapeReshapegradients_1/loss_2/add_grad/Sum!gradients_1/loss_2/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
!gradients_1/loss_2/add_grad/Sum_1Sum+gradients_1/loss_2/Sigmoid_grad/SigmoidGrad3gradients_1/loss_2/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/add_grad/Reshape_1Reshape!gradients_1/loss_2/add_grad/Sum_1#gradients_1/loss_2/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
В
,gradients_1/loss_2/add_grad/tuple/group_depsNoOp$^gradients_1/loss_2/add_grad/Reshape&^gradients_1/loss_2/add_grad/Reshape_1
ъ
4gradients_1/loss_2/add_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/add_grad/Reshape-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_1/loss_2/add_grad/Reshape
А
6gradients_1/loss_2/add_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/add_grad/Reshape_1-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
’
3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_1_grad/Shape%gradients_1/loss_2/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_1/loss_2/sub_1_grad/SumSum4gradients_1/loss_2/add_grad/tuple/control_dependency3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/sub_1_grad/ReshapeReshape!gradients_1/loss_2/sub_1_grad/Sum#gradients_1/loss_2/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
„
#gradients_1/loss_2/sub_1_grad/Sum_1Sum4gradients_1/loss_2/add_grad/tuple/control_dependency5gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_1/loss_2/sub_1_grad/NegNeg#gradients_1/loss_2/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_1/loss_2/sub_1_grad/Reshape_1Reshape!gradients_1/loss_2/sub_1_grad/Neg%gradients_1/loss_2/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
И
.gradients_1/loss_2/sub_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_1_grad/Reshape(^gradients_1/loss_2/sub_1_grad/Reshape_1
В
6gradients_1/loss_2/sub_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_1_grad/Reshape/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_1_grad/Reshape
И
8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_1_grad/Reshape_1/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
 gradients_1/loss_2/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_1/loss_2/Sum_grad/addAddloss_2/Sum/reduction_indices gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_1/loss_2/Sum_grad/modFloorModgradients_1/loss_2/Sum_grad/add gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_1/loss_2/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_1/loss_2/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_1/loss_2/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_1/loss_2/Sum_grad/rangeRange'gradients_1/loss_2/Sum_grad/range/start gradients_1/loss_2/Sum_grad/Size'gradients_1/loss_2/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_1/loss_2/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_1/loss_2/Sum_grad/FillFill#gradients_1/loss_2/Sum_grad/Shape_1&gradients_1/loss_2/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_1/loss_2/Sum_grad/DynamicStitchDynamicStitch!gradients_1/loss_2/Sum_grad/rangegradients_1/loss_2/Sum_grad/mod!gradients_1/loss_2/Sum_grad/Shape gradients_1/loss_2/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
N*
T0
g
%gradients_1/loss_2/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_1/loss_2/Sum_grad/MaximumMaximum)gradients_1/loss_2/Sum_grad/DynamicStitch%gradients_1/loss_2/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_1/loss_2/Sum_grad/floordivFloorDiv!gradients_1/loss_2/Sum_grad/Shape#gradients_1/loss_2/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_1/loss_2/Sum_grad/ReshapeReshape6gradients_1/loss_2/add_grad/tuple/control_dependency_1)gradients_1/loss_2/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
Ј
 gradients_1/loss_2/Sum_grad/TileTile#gradients_1/loss_2/Sum_grad/Reshape$gradients_1/loss_2/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_1/AddNAddN6gradients_1/loss_2/pow_2_grad/tuple/control_dependency6gradients_1/loss_2/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape
†
+gradients_1/loss_2/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_1/item_bias
Е
*gradients_1/loss_2/pos_item_bias_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_1/loss_2/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/pos_item_bias_grad/Size4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_1/loss_2/pos_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/pos_item_bias_grad/Shape9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_1/loss_2/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_1/loss_2/pos_item_bias_grad/concatConcatV20gradients_1/loss_2/pos_item_bias_grad/ExpandDims3gradients_1/loss_2/pos_item_bias_grad/strided_slice1gradients_1/loss_2/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
і
-gradients_1/loss_2/pos_item_bias_grad/ReshapeReshapegradients_1/AddN,gradients_1/loss_2/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_1/loss_2/pos_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_pos_items0gradients_1/loss_2/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
э
gradients_1/AddN_1AddN6gradients_1/loss_2/pow_4_grad/tuple/control_dependency8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape
†
+gradients_1/loss_2/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_1/item_bias
Е
*gradients_1/loss_2/neg_item_bias_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_1/loss_2/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/neg_item_bias_grad/Size4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_1/loss_2/neg_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/neg_item_bias_grad/Shape9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_1/loss_2/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_1/loss_2/neg_item_bias_grad/concatConcatV20gradients_1/loss_2/neg_item_bias_grad/ExpandDims3gradients_1/loss_2/neg_item_bias_grad/strided_slice1gradients_1/loss_2/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ґ
-gradients_1/loss_2/neg_item_bias_grad/ReshapeReshapegradients_1/AddN_1,gradients_1/loss_2/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_1/loss_2/neg_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_neg_items0gradients_1/loss_2/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
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
ѕ
1gradients_1/loss_2/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/mul_grad/Shape#gradients_1/loss_2/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_1/loss_2/mul_grad/mulMul gradients_1/loss_2/Sum_grad/Tile
loss_2/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_1/loss_2/mul_grad/SumSumgradients_1/loss_2/mul_grad/mul1gradients_1/loss_2/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_1/loss_2/mul_grad/ReshapeReshapegradients_1/loss_2/mul_grad/Sum!gradients_1/loss_2/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
К
!gradients_1/loss_2/mul_grad/mul_1Mulloss_2/users gradients_1/loss_2/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_1/loss_2/mul_grad/Sum_1Sum!gradients_1/loss_2/mul_grad/mul_13gradients_1/loss_2/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_1/loss_2/mul_grad/Reshape_1Reshape!gradients_1/loss_2/mul_grad/Sum_1#gradients_1/loss_2/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_1/loss_2/mul_grad/tuple/group_depsNoOp$^gradients_1/loss_2/mul_grad/Reshape&^gradients_1/loss_2/mul_grad/Reshape_1
ю
4gradients_1/loss_2/mul_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/mul_grad/Reshape-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_1/loss_2/mul_grad/Reshape
Д
6gradients_1/loss_2/mul_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/mul_grad/Reshape_1-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_grad/Reshape_1
Y
gradients_1/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_1/concatConcatV2-gradients_1/loss_2/pos_item_bias_grad/Reshape-gradients_1/loss_2/neg_item_bias_grad/Reshapegradients_1/concat/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_1/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_1/concat_1ConcatV2/gradients_1/loss_2/pos_item_bias_grad/Reshape_1/gradients_1/loss_2/neg_item_bias_grad/Reshape_1gradients_1/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
щ
gradients_1/AddN_2AddN4gradients_1/loss_2/pow_grad/tuple/control_dependency4gradients_1/loss_2/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape
°
#gradients_1/loss_2/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_1/user_factors
y
"gradients_1/loss_2/users_grad/SizeSizeplaceholders_1/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_1/loss_2/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_1/loss_2/users_grad/ExpandDims
ExpandDims"gradients_1/loss_2/users_grad/Size,gradients_1/loss_2/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_1/loss_2/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_1/loss_2/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_1/loss_2/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_1/loss_2/users_grad/strided_sliceStridedSlice#gradients_1/loss_2/users_grad/Shape1gradients_1/loss_2/users_grad/strided_slice/stack3gradients_1/loss_2/users_grad/strided_slice/stack_13gradients_1/loss_2/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_1/loss_2/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_1/loss_2/users_grad/concatConcatV2(gradients_1/loss_2/users_grad/ExpandDims+gradients_1/loss_2/users_grad/strided_slice)gradients_1/loss_2/users_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
≥
%gradients_1/loss_2/users_grad/ReshapeReshapegradients_1/AddN_2$gradients_1/loss_2/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
ґ
'gradients_1/loss_2/users_grad/Reshape_1Reshapeplaceholders_1/sampled_users(gradients_1/loss_2/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
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
ѕ
1gradients_1/loss_2/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/sub_grad/Shape#gradients_1/loss_2/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_1/loss_2/sub_grad/SumSum6gradients_1/loss_2/mul_grad/tuple/control_dependency_11gradients_1/loss_2/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_1/loss_2/sub_grad/ReshapeReshapegradients_1/loss_2/sub_grad/Sum!gradients_1/loss_2/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
’
!gradients_1/loss_2/sub_grad/Sum_1Sum6gradients_1/loss_2/mul_grad/tuple/control_dependency_13gradients_1/loss_2/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_1/loss_2/sub_grad/NegNeg!gradients_1/loss_2/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_1/loss_2/sub_grad/Reshape_1Reshapegradients_1/loss_2/sub_grad/Neg#gradients_1/loss_2/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_1/loss_2/sub_grad/tuple/group_depsNoOp$^gradients_1/loss_2/sub_grad/Reshape&^gradients_1/loss_2/sub_grad/Reshape_1
ю
4gradients_1/loss_2/sub_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/sub_grad/Reshape-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_1/loss_2/sub_grad/Reshape
Д
6gradients_1/loss_2/sub_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/sub_grad/Reshape_1-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_grad/Reshape_1
э
gradients_1/AddN_3AddN6gradients_1/loss_2/pow_1_grad/tuple/control_dependency4gradients_1/loss_2/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape
•
'gradients_1/loss_2/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_1/item_factors
Б
&gradients_1/loss_2/pos_items_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_1/loss_2/pos_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/pos_items_grad/Size0gradients_1/loss_2/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_1/loss_2/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_1/loss_2/pos_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/pos_items_grad/Shape5gradients_1/loss_2/pos_items_grad/strided_slice/stack7gradients_1/loss_2/pos_items_grad/strided_slice/stack_17gradients_1/loss_2/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_1/loss_2/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_1/loss_2/pos_items_grad/concatConcatV2,gradients_1/loss_2/pos_items_grad/ExpandDims/gradients_1/loss_2/pos_items_grad/strided_slice-gradients_1/loss_2/pos_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_1/loss_2/pos_items_grad/ReshapeReshapegradients_1/AddN_3(gradients_1/loss_2/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_1/loss_2/pos_items_grad/Reshape_1Reshape placeholders_1/sampled_pos_items,gradients_1/loss_2/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
€
gradients_1/AddN_4AddN6gradients_1/loss_2/pow_3_grad/tuple/control_dependency6gradients_1/loss_2/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape
•
'gradients_1/loss_2/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_1/item_factors
Б
&gradients_1/loss_2/neg_items_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_1/loss_2/neg_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/neg_items_grad/Size0gradients_1/loss_2/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_1/loss_2/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_1/loss_2/neg_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/neg_items_grad/Shape5gradients_1/loss_2/neg_items_grad/strided_slice/stack7gradients_1/loss_2/neg_items_grad/strided_slice/stack_17gradients_1/loss_2/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_1/loss_2/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_1/loss_2/neg_items_grad/concatConcatV2,gradients_1/loss_2/neg_items_grad/ExpandDims/gradients_1/loss_2/neg_items_grad/strided_slice-gradients_1/loss_2/neg_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_1/loss_2/neg_items_grad/ReshapeReshapegradients_1/AddN_4(gradients_1/loss_2/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_1/loss_2/neg_items_grad/Reshape_1Reshape placeholders_1/sampled_neg_items,gradients_1/loss_2/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
[
gradients_1/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_1/concat_2ConcatV2)gradients_1/loss_2/pos_items_grad/Reshape)gradients_1/loss_2/neg_items_grad/Reshapegradients_1/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_1/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_1/concat_3ConcatV2+gradients_1/loss_2/pos_items_grad/Reshape_1+gradients_1/loss_2/neg_items_grad/Reshape_1gradients_1/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
d
GradientDescent_1/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_1/update_variables_1/user_factors/mulMul%gradients_1/loss_2/users_grad/ReshapeGradientDescent_1/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_1/user_factors
Њ
<GradientDescent_1/update_variables_1/user_factors/ScatterSub
ScatterSubvariables_1/user_factors'gradients_1/loss_2/users_grad/Reshape_15GradientDescent_1/update_variables_1/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_1/user_factors
џ
5GradientDescent_1/update_variables_1/item_factors/mulMulgradients_1/concat_2GradientDescent_1/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_1/item_factors
Ђ
<GradientDescent_1/update_variables_1/item_factors/ScatterSub
ScatterSubvariables_1/item_factorsgradients_1/concat_35GradientDescent_1/update_variables_1/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_1/item_factors
∆
2GradientDescent_1/update_variables_1/item_bias/mulMulgradients_1/concatGradientDescent_1/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_1/item_bias
Ы
9GradientDescent_1/update_variables_1/item_bias/ScatterSub
ScatterSubvariables_1/item_biasgradients_1/concat_12GradientDescent_1/update_variables_1/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_1/item_bias
”
GradientDescent_1NoOp=^GradientDescent_1/update_variables_1/user_factors/ScatterSub=^GradientDescent_1/update_variables_1/item_factors/ScatterSub:^GradientDescent_1/update_variables_1/item_bias/ScatterSub
R
loss_3/tagsConst*
valueB Bloss_3*
_output_shapes
: *
dtype0
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
ќ
init_1NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign
j
placeholders_2/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_2/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_2/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_2/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_2/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_2/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_2/truncated_normal/TruncatedNormalTruncatedNormal"variables_2/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_2/truncated_normal/mulMul,variables_2/truncated_normal/TruncatedNormal#variables_2/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_2/truncated_normalAdd variables_2/truncated_normal/mul!variables_2/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_2/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_2/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_2/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_2/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_2/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_2/truncated_normal_1/mulMul.variables_2/truncated_normal_1/TruncatedNormal%variables_2/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_2/truncated_normal_1Add"variables_2/truncated_normal_1/mul#variables_2/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_2/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_2/user_factors/AssignAssignvariables_2/user_factorsvariables_2/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_2/user_factors
Ъ
variables_2/user_factors/readIdentityvariables_2/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_2/user_factors
О
variables_2/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_2/item_factors/AssignAssignvariables_2/item_factorsvariables_2/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_2/item_factors
Ъ
variables_2/item_factors/readIdentityvariables_2/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_2/item_factors
`
variables_2/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_2/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_2/item_bias/AssignAssignvariables_2/item_biasvariables_2/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_2/item_bias
Н
variables_2/item_bias/readIdentityvariables_2/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_2/item_bias
≥
loss_4/usersGathervariables_2/user_factors/readplaceholders_2/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_4/pos_itemsGathervariables_2/item_factors/read placeholders_2/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_4/neg_itemsGathervariables_2/item_factors/read placeholders_2/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_4/pos_item_biasGathervariables_2/item_bias/read placeholders_2/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_4/neg_item_biasGathervariables_2/item_bias/read placeholders_2/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_4/subSubloss_4/pos_itemsloss_4/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_4/mulMulloss_4/users
loss_4/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_4/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_4/SumSum
loss_4/mulloss_4/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_4/sub_1Subloss_4/pos_item_biasloss_4/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_4/addAddloss_4/sub_1
loss_4/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_4/SigmoidSigmoid
loss_4/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_4/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_4/clip_by_value/MinimumMinimumloss_4/Sigmoidloss_4/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_4/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_4/clip_by_valueMaximumloss_4/clip_by_value/Minimumloss_4/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_4/LogLogloss_4/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_4/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_4/Sum_1Sum
loss_4/Logloss_4/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_4/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_4/powPowloss_4/usersloss_4/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_4/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_4/Sum_2Sum
loss_4/powloss_4/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_4/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_4/mul_1Mulloss_4/mul_1/xloss_4/Sum_2*
_output_shapes
: *
T0
S
loss_4/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_1Powloss_4/pos_itemsloss_4/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_4/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_4/Sum_3Sumloss_4/pow_1loss_4/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_4/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_4/mul_2Mulloss_4/mul_2/xloss_4/Sum_3*
_output_shapes
: *
T0
S
loss_4/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_2Powloss_4/pos_item_biasloss_4/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_4/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_4/Sum_4Sumloss_4/pow_2loss_4/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_4/add_1Addloss_4/mul_2loss_4/Sum_4*
_output_shapes
: *
T0
S
loss_4/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_3Powloss_4/neg_itemsloss_4/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_4/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_4/Sum_5Sumloss_4/pow_3loss_4/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_4/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_4/mul_3Mulloss_4/mul_3/xloss_4/Sum_5*
_output_shapes
: *
T0
S
loss_4/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_4Powloss_4/neg_item_biasloss_4/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_4/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_4/Sum_6Sumloss_4/pow_4loss_4/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_4/add_2Addloss_4/mul_3loss_4/Sum_6*
_output_shapes
: *
T0
P
loss_4/add_3Addloss_4/mul_1loss_4/add_1*
_output_shapes
: *
T0
P
loss_4/add_4Addloss_4/add_3loss_4/add_2*
_output_shapes
: *
T0
P
loss_4/sub_2Subloss_4/add_4loss_4/Sum_1*
_output_shapes
: *
T0
T
gradients_2/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_2/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_2/FillFillgradients_2/Shapegradients_2/Const*
_output_shapes
: *
T0
f
#gradients_2/loss_4/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/sub_2_grad/Shape%gradients_2/loss_4/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_2/loss_4/sub_2_grad/SumSumgradients_2/Fill3gradients_2/loss_4/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/sub_2_grad/ReshapeReshape!gradients_2/loss_4/sub_2_grad/Sum#gradients_2/loss_4/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
≥
#gradients_2/loss_4/sub_2_grad/Sum_1Sumgradients_2/Fill5gradients_2/loss_4/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_2/loss_4/sub_2_grad/NegNeg#gradients_2/loss_4/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_2/loss_4/sub_2_grad/Reshape_1Reshape!gradients_2/loss_4/sub_2_grad/Neg%gradients_2/loss_4/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/sub_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/sub_2_grad/Reshape(^gradients_2/loss_4/sub_2_grad/Reshape_1
х
6gradients_2/loss_4/sub_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/sub_2_grad/Reshape/^gradients_2/loss_4/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/sub_2_grad/Reshape
ы
8gradients_2/loss_4/sub_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/sub_2_grad/Reshape_1/^gradients_2/loss_4/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/sub_2_grad/Reshape_1
f
#gradients_2/loss_4/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_4_grad/Shape%gradients_2/loss_4/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_2/loss_4/add_4_grad/SumSum6gradients_2/loss_4/sub_2_grad/tuple/control_dependency3gradients_2/loss_4/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_4_grad/ReshapeReshape!gradients_2/loss_4/add_4_grad/Sum#gradients_2/loss_4/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_2/loss_4/add_4_grad/Sum_1Sum6gradients_2/loss_4/sub_2_grad/tuple/control_dependency5gradients_2/loss_4/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_4_grad/Reshape_1Reshape#gradients_2/loss_4/add_4_grad/Sum_1%gradients_2/loss_4/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/add_4_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_4_grad/Reshape(^gradients_2/loss_4/add_4_grad/Reshape_1
х
6gradients_2/loss_4/add_4_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_4_grad/Reshape/^gradients_2/loss_4/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_4_grad/Reshape
ы
8gradients_2/loss_4/add_4_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_4_grad/Reshape_1/^gradients_2/loss_4/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_4_grad/Reshape_1
u
+gradients_2/loss_4/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_2/loss_4/Sum_1_grad/ReshapeReshape8gradients_2/loss_4/sub_2_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
m
#gradients_2/loss_4/Sum_1_grad/ShapeShape
loss_4/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_2/loss_4/Sum_1_grad/TileTile%gradients_2/loss_4/Sum_1_grad/Reshape#gradients_2/loss_4/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_2/loss_4/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_3_grad/Shape%gradients_2/loss_4/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_2/loss_4/add_3_grad/SumSum6gradients_2/loss_4/add_4_grad/tuple/control_dependency3gradients_2/loss_4/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_3_grad/ReshapeReshape!gradients_2/loss_4/add_3_grad/Sum#gradients_2/loss_4/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_2/loss_4/add_3_grad/Sum_1Sum6gradients_2/loss_4/add_4_grad/tuple/control_dependency5gradients_2/loss_4/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_3_grad/Reshape_1Reshape#gradients_2/loss_4/add_3_grad/Sum_1%gradients_2/loss_4/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/add_3_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_3_grad/Reshape(^gradients_2/loss_4/add_3_grad/Reshape_1
х
6gradients_2/loss_4/add_3_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_3_grad/Reshape/^gradients_2/loss_4/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_3_grad/Reshape
ы
8gradients_2/loss_4/add_3_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_3_grad/Reshape_1/^gradients_2/loss_4/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_3_grad/Reshape_1
f
#gradients_2/loss_4/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_2_grad/Shape%gradients_2/loss_4/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_2/loss_4/add_2_grad/SumSum8gradients_2/loss_4/add_4_grad/tuple/control_dependency_13gradients_2/loss_4/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_2_grad/ReshapeReshape!gradients_2/loss_4/add_2_grad/Sum#gradients_2/loss_4/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_2/loss_4/add_2_grad/Sum_1Sum8gradients_2/loss_4/add_4_grad/tuple/control_dependency_15gradients_2/loss_4/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_2_grad/Reshape_1Reshape#gradients_2/loss_4/add_2_grad/Sum_1%gradients_2/loss_4/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/add_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_2_grad/Reshape(^gradients_2/loss_4/add_2_grad/Reshape_1
х
6gradients_2/loss_4/add_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_2_grad/Reshape/^gradients_2/loss_4/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_2_grad/Reshape
ы
8gradients_2/loss_4/add_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_2_grad/Reshape_1/^gradients_2/loss_4/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_2_grad/Reshape_1
Э
&gradients_2/loss_4/Log_grad/Reciprocal
Reciprocalloss_4/clip_by_value#^gradients_2/loss_4/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_2/loss_4/Log_grad/mulMul"gradients_2/loss_4/Sum_1_grad/Tile&gradients_2/loss_4/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_2/loss_4/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/mul_1_grad/Shape%gradients_2/loss_4/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_2/loss_4/mul_1_grad/mulMul6gradients_2/loss_4/add_3_grad/tuple/control_dependencyloss_4/Sum_2*
_output_shapes
: *
T0
ј
!gradients_2/loss_4/mul_1_grad/SumSum!gradients_2/loss_4/mul_1_grad/mul3gradients_2/loss_4/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/mul_1_grad/ReshapeReshape!gradients_2/loss_4/mul_1_grad/Sum#gradients_2/loss_4/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_2/loss_4/mul_1_grad/mul_1Mulloss_4/mul_1/x6gradients_2/loss_4/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_2/loss_4/mul_1_grad/Sum_1Sum#gradients_2/loss_4/mul_1_grad/mul_15gradients_2/loss_4/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/mul_1_grad/Reshape_1Reshape#gradients_2/loss_4/mul_1_grad/Sum_1%gradients_2/loss_4/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/mul_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/mul_1_grad/Reshape(^gradients_2/loss_4/mul_1_grad/Reshape_1
х
6gradients_2/loss_4/mul_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/mul_1_grad/Reshape/^gradients_2/loss_4/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_1_grad/Reshape
ы
8gradients_2/loss_4/mul_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/mul_1_grad/Reshape_1/^gradients_2/loss_4/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/mul_1_grad/Reshape_1
f
#gradients_2/loss_4/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_1_grad/Shape%gradients_2/loss_4/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_2/loss_4/add_1_grad/SumSum8gradients_2/loss_4/add_3_grad/tuple/control_dependency_13gradients_2/loss_4/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_1_grad/ReshapeReshape!gradients_2/loss_4/add_1_grad/Sum#gradients_2/loss_4/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_2/loss_4/add_1_grad/Sum_1Sum8gradients_2/loss_4/add_3_grad/tuple/control_dependency_15gradients_2/loss_4/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_1_grad/Reshape_1Reshape#gradients_2/loss_4/add_1_grad/Sum_1%gradients_2/loss_4/add_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/add_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_1_grad/Reshape(^gradients_2/loss_4/add_1_grad/Reshape_1
х
6gradients_2/loss_4/add_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_1_grad/Reshape/^gradients_2/loss_4/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_1_grad/Reshape
ы
8gradients_2/loss_4/add_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_1_grad/Reshape_1/^gradients_2/loss_4/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_1_grad/Reshape_1
f
#gradients_2/loss_4/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/mul_3_grad/Shape%gradients_2/loss_4/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_2/loss_4/mul_3_grad/mulMul6gradients_2/loss_4/add_2_grad/tuple/control_dependencyloss_4/Sum_5*
_output_shapes
: *
T0
ј
!gradients_2/loss_4/mul_3_grad/SumSum!gradients_2/loss_4/mul_3_grad/mul3gradients_2/loss_4/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/mul_3_grad/ReshapeReshape!gradients_2/loss_4/mul_3_grad/Sum#gradients_2/loss_4/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_2/loss_4/mul_3_grad/mul_1Mulloss_4/mul_3/x6gradients_2/loss_4/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_2/loss_4/mul_3_grad/Sum_1Sum#gradients_2/loss_4/mul_3_grad/mul_15gradients_2/loss_4/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/mul_3_grad/Reshape_1Reshape#gradients_2/loss_4/mul_3_grad/Sum_1%gradients_2/loss_4/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/mul_3_grad/tuple/group_depsNoOp&^gradients_2/loss_4/mul_3_grad/Reshape(^gradients_2/loss_4/mul_3_grad/Reshape_1
х
6gradients_2/loss_4/mul_3_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/mul_3_grad/Reshape/^gradients_2/loss_4/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_3_grad/Reshape
ы
8gradients_2/loss_4/mul_3_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/mul_3_grad/Reshape_1/^gradients_2/loss_4/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/mul_3_grad/Reshape_1
u
+gradients_2/loss_4/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_2/loss_4/Sum_6_grad/ReshapeReshape8gradients_2/loss_4/add_2_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_6_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_2/loss_4/Sum_6_grad/ShapeShapeloss_4/pow_4*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_2/loss_4/Sum_6_grad/TileTile%gradients_2/loss_4/Sum_6_grad/Reshape#gradients_2/loss_4/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_2/loss_4/clip_by_value_grad/ShapeShapeloss_4/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_2/loss_4/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_2/loss_4/clip_by_value_grad/Shape_2Shapegradients_2/loss_4/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_2/loss_4/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_2/loss_4/clip_by_value_grad/zerosFill-gradients_2/loss_4/clip_by_value_grad/Shape_21gradients_2/loss_4/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_2/loss_4/clip_by_value_grad/GreaterEqualGreaterEqualloss_4/clip_by_value/Minimumloss_4/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_2/loss_4/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_2/loss_4/clip_by_value_grad/Shape-gradients_2/loss_4/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_2/loss_4/clip_by_value_grad/SelectSelect2gradients_2/loss_4/clip_by_value_grad/GreaterEqualgradients_2/loss_4/Log_grad/mul+gradients_2/loss_4/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_2/loss_4/clip_by_value_grad/LogicalNot
LogicalNot2gradients_2/loss_4/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_2/loss_4/clip_by_value_grad/Select_1Select0gradients_2/loss_4/clip_by_value_grad/LogicalNotgradients_2/loss_4/Log_grad/mul+gradients_2/loss_4/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_2/loss_4/clip_by_value_grad/SumSum,gradients_2/loss_4/clip_by_value_grad/Select;gradients_2/loss_4/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_2/loss_4/clip_by_value_grad/ReshapeReshape)gradients_2/loss_4/clip_by_value_grad/Sum+gradients_2/loss_4/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
б
+gradients_2/loss_4/clip_by_value_grad/Sum_1Sum.gradients_2/loss_4/clip_by_value_grad/Select_1=gradients_2/loss_4/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_2/loss_4/clip_by_value_grad/Reshape_1Reshape+gradients_2/loss_4/clip_by_value_grad/Sum_1-gradients_2/loss_4/clip_by_value_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
†
6gradients_2/loss_4/clip_by_value_grad/tuple/group_depsNoOp.^gradients_2/loss_4/clip_by_value_grad/Reshape0^gradients_2/loss_4/clip_by_value_grad/Reshape_1
Ґ
>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_2/loss_4/clip_by_value_grad/Reshape7^gradients_2/loss_4/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_2/loss_4/clip_by_value_grad/Reshape
Ы
@gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_2/loss_4/clip_by_value_grad/Reshape_17^gradients_2/loss_4/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_2/loss_4/clip_by_value_grad/Reshape_1
|
+gradients_2/loss_4/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_2/loss_4/Sum_2_grad/ReshapeReshape8gradients_2/loss_4/mul_1_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_2_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
m
#gradients_2/loss_4/Sum_2_grad/ShapeShape
loss_4/pow*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_2/loss_4/Sum_2_grad/TileTile%gradients_2/loss_4/Sum_2_grad/Reshape#gradients_2/loss_4/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_2/loss_4/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/mul_2_grad/Shape%gradients_2/loss_4/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_2/loss_4/mul_2_grad/mulMul6gradients_2/loss_4/add_1_grad/tuple/control_dependencyloss_4/Sum_3*
_output_shapes
: *
T0
ј
!gradients_2/loss_4/mul_2_grad/SumSum!gradients_2/loss_4/mul_2_grad/mul3gradients_2/loss_4/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/mul_2_grad/ReshapeReshape!gradients_2/loss_4/mul_2_grad/Sum#gradients_2/loss_4/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_2/loss_4/mul_2_grad/mul_1Mulloss_4/mul_2/x6gradients_2/loss_4/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_2/loss_4/mul_2_grad/Sum_1Sum#gradients_2/loss_4/mul_2_grad/mul_15gradients_2/loss_4/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/mul_2_grad/Reshape_1Reshape#gradients_2/loss_4/mul_2_grad/Sum_1%gradients_2/loss_4/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/mul_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/mul_2_grad/Reshape(^gradients_2/loss_4/mul_2_grad/Reshape_1
х
6gradients_2/loss_4/mul_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/mul_2_grad/Reshape/^gradients_2/loss_4/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_2_grad/Reshape
ы
8gradients_2/loss_4/mul_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/mul_2_grad/Reshape_1/^gradients_2/loss_4/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/mul_2_grad/Reshape_1
u
+gradients_2/loss_4/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_2/loss_4/Sum_4_grad/ReshapeReshape8gradients_2/loss_4/add_1_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_4_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_2/loss_4/Sum_4_grad/ShapeShapeloss_4/pow_2*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_2/loss_4/Sum_4_grad/TileTile%gradients_2/loss_4/Sum_4_grad/Reshape#gradients_2/loss_4/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_2/loss_4/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_2/loss_4/Sum_5_grad/ReshapeReshape8gradients_2/loss_4/mul_3_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_5_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_2/loss_4/Sum_5_grad/ShapeShapeloss_4/pow_3*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_2/loss_4/Sum_5_grad/TileTile%gradients_2/loss_4/Sum_5_grad/Reshape#gradients_2/loss_4/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_2/loss_4/pow_4_grad/ShapeShapeloss_4/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_4_grad/Shape%gradients_2/loss_4/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_2/loss_4/pow_4_grad/mulMul"gradients_2/loss_4/Sum_6_grad/Tileloss_4/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_2/loss_4/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_4_grad/subSubloss_4/pow_4/y#gradients_2/loss_4/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_4_grad/PowPowloss_4/neg_item_bias!gradients_2/loss_4/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_2/loss_4/pow_4_grad/mul_1Mul!gradients_2/loss_4/pow_4_grad/mul!gradients_2/loss_4/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_2/loss_4/pow_4_grad/SumSum#gradients_2/loss_4/pow_4_grad/mul_13gradients_2/loss_4/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/pow_4_grad/ReshapeReshape!gradients_2/loss_4/pow_4_grad/Sum#gradients_2/loss_4/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_2/loss_4/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_4_grad/GreaterGreaterloss_4/neg_item_bias'gradients_2/loss_4/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_2/loss_4/pow_4_grad/LogLogloss_4/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_2/loss_4/pow_4_grad/zeros_like	ZerosLikeloss_4/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_2/loss_4/pow_4_grad/SelectSelect%gradients_2/loss_4/pow_4_grad/Greater!gradients_2/loss_4/pow_4_grad/Log(gradients_2/loss_4/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_2/loss_4/pow_4_grad/mul_2Mul"gradients_2/loss_4/Sum_6_grad/Tileloss_4/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_2/loss_4/pow_4_grad/mul_3Mul#gradients_2/loss_4/pow_4_grad/mul_2$gradients_2/loss_4/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_2/loss_4/pow_4_grad/Sum_1Sum#gradients_2/loss_4/pow_4_grad/mul_35gradients_2/loss_4/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_4_grad/Reshape_1Reshape#gradients_2/loss_4/pow_4_grad/Sum_1%gradients_2/loss_4/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/pow_4_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_4_grad/Reshape(^gradients_2/loss_4/pow_4_grad/Reshape_1
В
6gradients_2/loss_4/pow_4_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_4_grad/Reshape/^gradients_2/loss_4/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_4_grad/Reshape
ы
8gradients_2/loss_4/pow_4_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_4_grad/Reshape_1/^gradients_2/loss_4/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_4_grad/Reshape_1
Б
3gradients_2/loss_4/clip_by_value/Minimum_grad/ShapeShapeloss_4/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_2Shape>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_2/loss_4/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_2/loss_4/clip_by_value/Minimum_grad/zerosFill5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_29gradients_2/loss_4/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_2/loss_4/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_4/Sigmoidloss_4/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_2/loss_4/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_2/loss_4/clip_by_value/Minimum_grad/Shape5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_2/loss_4/clip_by_value/Minimum_grad/SelectSelect7gradients_2/loss_4/clip_by_value/Minimum_grad/LessEqual>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency3gradients_2/loss_4/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_2/loss_4/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_2/loss_4/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_2/loss_4/clip_by_value/Minimum_grad/Select_1Select8gradients_2/loss_4/clip_by_value/Minimum_grad/LogicalNot>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency3gradients_2/loss_4/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_2/loss_4/clip_by_value/Minimum_grad/SumSum4gradients_2/loss_4/clip_by_value/Minimum_grad/SelectCgradients_2/loss_4/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_2/loss_4/clip_by_value/Minimum_grad/ReshapeReshape1gradients_2/loss_4/clip_by_value/Minimum_grad/Sum3gradients_2/loss_4/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
щ
3gradients_2/loss_4/clip_by_value/Minimum_grad/Sum_1Sum6gradients_2/loss_4/clip_by_value/Minimum_grad/Select_1Egradients_2/loss_4/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_2/loss_4/clip_by_value/Minimum_grad/Sum_15gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
Є
>gradients_2/loss_4/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape8^gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_2/loss_4/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape?^gradients_2/loss_4/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_2/loss_4/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1?^gradients_2/loss_4/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_2/loss_4/pow_grad/ShapeShapeloss_4/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_2/loss_4/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_2/loss_4/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/pow_grad/Shape#gradients_2/loss_4/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_2/loss_4/pow_grad/mulMul"gradients_2/loss_4/Sum_2_grad/Tileloss_4/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_2/loss_4/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_2/loss_4/pow_grad/subSubloss_4/pow/y!gradients_2/loss_4/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_2/loss_4/pow_grad/PowPowloss_4/usersgradients_2/loss_4/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_2/loss_4/pow_grad/mul_1Mulgradients_2/loss_4/pow_grad/mulgradients_2/loss_4/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_2/loss_4/pow_grad/SumSum!gradients_2/loss_4/pow_grad/mul_11gradients_2/loss_4/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_2/loss_4/pow_grad/ReshapeReshapegradients_2/loss_4/pow_grad/Sum!gradients_2/loss_4/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
j
%gradients_2/loss_4/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_2/loss_4/pow_grad/GreaterGreaterloss_4/users%gradients_2/loss_4/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_2/loss_4/pow_grad/LogLogloss_4/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_2/loss_4/pow_grad/zeros_like	ZerosLikeloss_4/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_2/loss_4/pow_grad/SelectSelect#gradients_2/loss_4/pow_grad/Greatergradients_2/loss_4/pow_grad/Log&gradients_2/loss_4/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_2/loss_4/pow_grad/mul_2Mul"gradients_2/loss_4/Sum_2_grad/Tile
loss_4/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_2/loss_4/pow_grad/mul_3Mul!gradients_2/loss_4/pow_grad/mul_2"gradients_2/loss_4/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_2/loss_4/pow_grad/Sum_1Sum!gradients_2/loss_4/pow_grad/mul_33gradients_2/loss_4/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/pow_grad/Reshape_1Reshape!gradients_2/loss_4/pow_grad/Sum_1#gradients_2/loss_4/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
В
,gradients_2/loss_4/pow_grad/tuple/group_depsNoOp$^gradients_2/loss_4/pow_grad/Reshape&^gradients_2/loss_4/pow_grad/Reshape_1
ю
4gradients_2/loss_4/pow_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/pow_grad/Reshape-^gradients_2/loss_4/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_2/loss_4/pow_grad/Reshape
у
6gradients_2/loss_4/pow_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/pow_grad/Reshape_1-^gradients_2/loss_4/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_grad/Reshape_1
|
+gradients_2/loss_4/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_2/loss_4/Sum_3_grad/ReshapeReshape8gradients_2/loss_4/mul_2_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_3_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_2/loss_4/Sum_3_grad/ShapeShapeloss_4/pow_1*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_2/loss_4/Sum_3_grad/TileTile%gradients_2/loss_4/Sum_3_grad/Reshape#gradients_2/loss_4/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_2/loss_4/pow_2_grad/ShapeShapeloss_4/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_2_grad/Shape%gradients_2/loss_4/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_2/loss_4/pow_2_grad/mulMul"gradients_2/loss_4/Sum_4_grad/Tileloss_4/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_2/loss_4/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_2_grad/subSubloss_4/pow_2/y#gradients_2/loss_4/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_2_grad/PowPowloss_4/pos_item_bias!gradients_2/loss_4/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_2/loss_4/pow_2_grad/mul_1Mul!gradients_2/loss_4/pow_2_grad/mul!gradients_2/loss_4/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_2/loss_4/pow_2_grad/SumSum#gradients_2/loss_4/pow_2_grad/mul_13gradients_2/loss_4/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/pow_2_grad/ReshapeReshape!gradients_2/loss_4/pow_2_grad/Sum#gradients_2/loss_4/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_2/loss_4/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_2_grad/GreaterGreaterloss_4/pos_item_bias'gradients_2/loss_4/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_2/loss_4/pow_2_grad/LogLogloss_4/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_2/loss_4/pow_2_grad/zeros_like	ZerosLikeloss_4/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_2/loss_4/pow_2_grad/SelectSelect%gradients_2/loss_4/pow_2_grad/Greater!gradients_2/loss_4/pow_2_grad/Log(gradients_2/loss_4/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_2/loss_4/pow_2_grad/mul_2Mul"gradients_2/loss_4/Sum_4_grad/Tileloss_4/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_2/loss_4/pow_2_grad/mul_3Mul#gradients_2/loss_4/pow_2_grad/mul_2$gradients_2/loss_4/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_2/loss_4/pow_2_grad/Sum_1Sum#gradients_2/loss_4/pow_2_grad/mul_35gradients_2/loss_4/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_2_grad/Reshape_1Reshape#gradients_2/loss_4/pow_2_grad/Sum_1%gradients_2/loss_4/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/pow_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_2_grad/Reshape(^gradients_2/loss_4/pow_2_grad/Reshape_1
В
6gradients_2/loss_4/pow_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_2_grad/Reshape/^gradients_2/loss_4/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_2_grad/Reshape
ы
8gradients_2/loss_4/pow_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_2_grad/Reshape_1/^gradients_2/loss_4/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_2_grad/Reshape_1
s
#gradients_2/loss_4/pow_3_grad/ShapeShapeloss_4/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_3_grad/Shape%gradients_2/loss_4/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_2/loss_4/pow_3_grad/mulMul"gradients_2/loss_4/Sum_5_grad/Tileloss_4/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_2/loss_4/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_3_grad/subSubloss_4/pow_3/y#gradients_2/loss_4/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_3_grad/PowPowloss_4/neg_items!gradients_2/loss_4/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_2/loss_4/pow_3_grad/mul_1Mul!gradients_2/loss_4/pow_3_grad/mul!gradients_2/loss_4/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_2/loss_4/pow_3_grad/SumSum#gradients_2/loss_4/pow_3_grad/mul_13gradients_2/loss_4/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_2/loss_4/pow_3_grad/ReshapeReshape!gradients_2/loss_4/pow_3_grad/Sum#gradients_2/loss_4/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_2/loss_4/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_3_grad/GreaterGreaterloss_4/neg_items'gradients_2/loss_4/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_2/loss_4/pow_3_grad/LogLogloss_4/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_2/loss_4/pow_3_grad/zeros_like	ZerosLikeloss_4/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_2/loss_4/pow_3_grad/SelectSelect%gradients_2/loss_4/pow_3_grad/Greater!gradients_2/loss_4/pow_3_grad/Log(gradients_2/loss_4/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_2/loss_4/pow_3_grad/mul_2Mul"gradients_2/loss_4/Sum_5_grad/Tileloss_4/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_2/loss_4/pow_3_grad/mul_3Mul#gradients_2/loss_4/pow_3_grad/mul_2$gradients_2/loss_4/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_2/loss_4/pow_3_grad/Sum_1Sum#gradients_2/loss_4/pow_3_grad/mul_35gradients_2/loss_4/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_3_grad/Reshape_1Reshape#gradients_2/loss_4/pow_3_grad/Sum_1%gradients_2/loss_4/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/pow_3_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_3_grad/Reshape(^gradients_2/loss_4/pow_3_grad/Reshape_1
Ж
6gradients_2/loss_4/pow_3_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_3_grad/Reshape/^gradients_2/loss_4/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_3_grad/Reshape
ы
8gradients_2/loss_4/pow_3_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_3_grad/Reshape_1/^gradients_2/loss_4/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_3_grad/Reshape_1
ј
+gradients_2/loss_4/Sigmoid_grad/SigmoidGradSigmoidGradloss_4/SigmoidFgradients_2/loss_4/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_2/loss_4/pow_1_grad/ShapeShapeloss_4/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_1_grad/Shape%gradients_2/loss_4/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_2/loss_4/pow_1_grad/mulMul"gradients_2/loss_4/Sum_3_grad/Tileloss_4/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_2/loss_4/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_1_grad/subSubloss_4/pow_1/y#gradients_2/loss_4/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_1_grad/PowPowloss_4/pos_items!gradients_2/loss_4/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_2/loss_4/pow_1_grad/mul_1Mul!gradients_2/loss_4/pow_1_grad/mul!gradients_2/loss_4/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_2/loss_4/pow_1_grad/SumSum#gradients_2/loss_4/pow_1_grad/mul_13gradients_2/loss_4/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_2/loss_4/pow_1_grad/ReshapeReshape!gradients_2/loss_4/pow_1_grad/Sum#gradients_2/loss_4/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_2/loss_4/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_1_grad/GreaterGreaterloss_4/pos_items'gradients_2/loss_4/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_2/loss_4/pow_1_grad/LogLogloss_4/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_2/loss_4/pow_1_grad/zeros_like	ZerosLikeloss_4/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_2/loss_4/pow_1_grad/SelectSelect%gradients_2/loss_4/pow_1_grad/Greater!gradients_2/loss_4/pow_1_grad/Log(gradients_2/loss_4/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_2/loss_4/pow_1_grad/mul_2Mul"gradients_2/loss_4/Sum_3_grad/Tileloss_4/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_2/loss_4/pow_1_grad/mul_3Mul#gradients_2/loss_4/pow_1_grad/mul_2$gradients_2/loss_4/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_2/loss_4/pow_1_grad/Sum_1Sum#gradients_2/loss_4/pow_1_grad/mul_35gradients_2/loss_4/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_1_grad/Reshape_1Reshape#gradients_2/loss_4/pow_1_grad/Sum_1%gradients_2/loss_4/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_2/loss_4/pow_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_1_grad/Reshape(^gradients_2/loss_4/pow_1_grad/Reshape_1
Ж
6gradients_2/loss_4/pow_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_1_grad/Reshape/^gradients_2/loss_4/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_1_grad/Reshape
ы
8gradients_2/loss_4/pow_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_1_grad/Reshape_1/^gradients_2/loss_4/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_1_grad/Reshape_1
m
!gradients_2/loss_4/add_grad/ShapeShapeloss_4/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_2/loss_4/add_grad/Shape_1Shape
loss_4/Sum*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_2/loss_4/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/add_grad/Shape#gradients_2/loss_4/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_2/loss_4/add_grad/SumSum+gradients_2/loss_4/Sigmoid_grad/SigmoidGrad1gradients_2/loss_4/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_2/loss_4/add_grad/ReshapeReshapegradients_2/loss_4/add_grad/Sum!gradients_2/loss_4/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
!gradients_2/loss_4/add_grad/Sum_1Sum+gradients_2/loss_4/Sigmoid_grad/SigmoidGrad3gradients_2/loss_4/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/add_grad/Reshape_1Reshape!gradients_2/loss_4/add_grad/Sum_1#gradients_2/loss_4/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
В
,gradients_2/loss_4/add_grad/tuple/group_depsNoOp$^gradients_2/loss_4/add_grad/Reshape&^gradients_2/loss_4/add_grad/Reshape_1
ъ
4gradients_2/loss_4/add_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/add_grad/Reshape-^gradients_2/loss_4/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_2/loss_4/add_grad/Reshape
А
6gradients_2/loss_4/add_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/add_grad/Reshape_1-^gradients_2/loss_4/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/add_grad/Reshape_1
w
#gradients_2/loss_4/sub_1_grad/ShapeShapeloss_4/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_2/loss_4/sub_1_grad/Shape_1Shapeloss_4/neg_item_bias*
_output_shapes
:*
T0*
out_type0
’
3gradients_2/loss_4/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/sub_1_grad/Shape%gradients_2/loss_4/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_2/loss_4/sub_1_grad/SumSum4gradients_2/loss_4/add_grad/tuple/control_dependency3gradients_2/loss_4/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/sub_1_grad/ReshapeReshape!gradients_2/loss_4/sub_1_grad/Sum#gradients_2/loss_4/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
„
#gradients_2/loss_4/sub_1_grad/Sum_1Sum4gradients_2/loss_4/add_grad/tuple/control_dependency5gradients_2/loss_4/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_2/loss_4/sub_1_grad/NegNeg#gradients_2/loss_4/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_2/loss_4/sub_1_grad/Reshape_1Reshape!gradients_2/loss_4/sub_1_grad/Neg%gradients_2/loss_4/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
И
.gradients_2/loss_4/sub_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/sub_1_grad/Reshape(^gradients_2/loss_4/sub_1_grad/Reshape_1
В
6gradients_2/loss_4/sub_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/sub_1_grad/Reshape/^gradients_2/loss_4/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/sub_1_grad/Reshape
И
8gradients_2/loss_4/sub_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/sub_1_grad/Reshape_1/^gradients_2/loss_4/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*:
_class0
.,loc:@gradients_2/loss_4/sub_1_grad/Reshape_1
k
!gradients_2/loss_4/Sum_grad/ShapeShape
loss_4/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_2/loss_4/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_2/loss_4/Sum_grad/addAddloss_4/Sum/reduction_indices gradients_2/loss_4/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_2/loss_4/Sum_grad/modFloorModgradients_2/loss_4/Sum_grad/add gradients_2/loss_4/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_2/loss_4/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_2/loss_4/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_2/loss_4/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_2/loss_4/Sum_grad/rangeRange'gradients_2/loss_4/Sum_grad/range/start gradients_2/loss_4/Sum_grad/Size'gradients_2/loss_4/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_2/loss_4/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_2/loss_4/Sum_grad/FillFill#gradients_2/loss_4/Sum_grad/Shape_1&gradients_2/loss_4/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_2/loss_4/Sum_grad/DynamicStitchDynamicStitch!gradients_2/loss_4/Sum_grad/rangegradients_2/loss_4/Sum_grad/mod!gradients_2/loss_4/Sum_grad/Shape gradients_2/loss_4/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
N*
T0
g
%gradients_2/loss_4/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_2/loss_4/Sum_grad/MaximumMaximum)gradients_2/loss_4/Sum_grad/DynamicStitch%gradients_2/loss_4/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_2/loss_4/Sum_grad/floordivFloorDiv!gradients_2/loss_4/Sum_grad/Shape#gradients_2/loss_4/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_2/loss_4/Sum_grad/ReshapeReshape6gradients_2/loss_4/add_grad/tuple/control_dependency_1)gradients_2/loss_4/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
Ј
 gradients_2/loss_4/Sum_grad/TileTile#gradients_2/loss_4/Sum_grad/Reshape$gradients_2/loss_4/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_2/AddNAddN6gradients_2/loss_4/pow_2_grad/tuple/control_dependency6gradients_2/loss_4/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_2_grad/Reshape
†
+gradients_2/loss_4/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_2/item_bias
Е
*gradients_2/loss_4/pos_item_bias_grad/SizeSize placeholders_2/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_2/loss_4/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_2/loss_4/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_2/loss_4/pos_item_bias_grad/Size4gradients_2/loss_4/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_2/loss_4/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_2/loss_4/pos_item_bias_grad/strided_sliceStridedSlice+gradients_2/loss_4/pos_item_bias_grad/Shape9gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_1;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_2/loss_4/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_2/loss_4/pos_item_bias_grad/concatConcatV20gradients_2/loss_4/pos_item_bias_grad/ExpandDims3gradients_2/loss_4/pos_item_bias_grad/strided_slice1gradients_2/loss_4/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
і
-gradients_2/loss_4/pos_item_bias_grad/ReshapeReshapegradients_2/AddN,gradients_2/loss_4/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_2/loss_4/pos_item_bias_grad/Reshape_1Reshape placeholders_2/sampled_pos_items0gradients_2/loss_4/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
э
gradients_2/AddN_1AddN6gradients_2/loss_4/pow_4_grad/tuple/control_dependency8gradients_2/loss_4/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_4_grad/Reshape
†
+gradients_2/loss_4/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_2/item_bias
Е
*gradients_2/loss_4/neg_item_bias_grad/SizeSize placeholders_2/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_2/loss_4/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_2/loss_4/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_2/loss_4/neg_item_bias_grad/Size4gradients_2/loss_4/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_2/loss_4/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_2/loss_4/neg_item_bias_grad/strided_sliceStridedSlice+gradients_2/loss_4/neg_item_bias_grad/Shape9gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_1;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_2/loss_4/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_2/loss_4/neg_item_bias_grad/concatConcatV20gradients_2/loss_4/neg_item_bias_grad/ExpandDims3gradients_2/loss_4/neg_item_bias_grad/strided_slice1gradients_2/loss_4/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ґ
-gradients_2/loss_4/neg_item_bias_grad/ReshapeReshapegradients_2/AddN_1,gradients_2/loss_4/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_2/loss_4/neg_item_bias_grad/Reshape_1Reshape placeholders_2/sampled_neg_items0gradients_2/loss_4/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
m
!gradients_2/loss_4/mul_grad/ShapeShapeloss_4/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_2/loss_4/mul_grad/Shape_1Shape
loss_4/sub*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_2/loss_4/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/mul_grad/Shape#gradients_2/loss_4/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_2/loss_4/mul_grad/mulMul gradients_2/loss_4/Sum_grad/Tile
loss_4/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_2/loss_4/mul_grad/SumSumgradients_2/loss_4/mul_grad/mul1gradients_2/loss_4/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_2/loss_4/mul_grad/ReshapeReshapegradients_2/loss_4/mul_grad/Sum!gradients_2/loss_4/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
К
!gradients_2/loss_4/mul_grad/mul_1Mulloss_4/users gradients_2/loss_4/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_2/loss_4/mul_grad/Sum_1Sum!gradients_2/loss_4/mul_grad/mul_13gradients_2/loss_4/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_2/loss_4/mul_grad/Reshape_1Reshape!gradients_2/loss_4/mul_grad/Sum_1#gradients_2/loss_4/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_2/loss_4/mul_grad/tuple/group_depsNoOp$^gradients_2/loss_4/mul_grad/Reshape&^gradients_2/loss_4/mul_grad/Reshape_1
ю
4gradients_2/loss_4/mul_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/mul_grad/Reshape-^gradients_2/loss_4/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_2/loss_4/mul_grad/Reshape
Д
6gradients_2/loss_4/mul_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/mul_grad/Reshape_1-^gradients_2/loss_4/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_grad/Reshape_1
Y
gradients_2/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_2/concatConcatV2-gradients_2/loss_4/pos_item_bias_grad/Reshape-gradients_2/loss_4/neg_item_bias_grad/Reshapegradients_2/concat/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_2/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_2/concat_1ConcatV2/gradients_2/loss_4/pos_item_bias_grad/Reshape_1/gradients_2/loss_4/neg_item_bias_grad/Reshape_1gradients_2/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
щ
gradients_2/AddN_2AddN4gradients_2/loss_4/pow_grad/tuple/control_dependency4gradients_2/loss_4/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*6
_class,
*(loc:@gradients_2/loss_4/pow_grad/Reshape
°
#gradients_2/loss_4/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_2/user_factors
y
"gradients_2/loss_4/users_grad/SizeSizeplaceholders_2/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_2/loss_4/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_2/loss_4/users_grad/ExpandDims
ExpandDims"gradients_2/loss_4/users_grad/Size,gradients_2/loss_4/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_2/loss_4/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_2/loss_4/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_2/loss_4/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_2/loss_4/users_grad/strided_sliceStridedSlice#gradients_2/loss_4/users_grad/Shape1gradients_2/loss_4/users_grad/strided_slice/stack3gradients_2/loss_4/users_grad/strided_slice/stack_13gradients_2/loss_4/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_2/loss_4/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_2/loss_4/users_grad/concatConcatV2(gradients_2/loss_4/users_grad/ExpandDims+gradients_2/loss_4/users_grad/strided_slice)gradients_2/loss_4/users_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
≥
%gradients_2/loss_4/users_grad/ReshapeReshapegradients_2/AddN_2$gradients_2/loss_4/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
ґ
'gradients_2/loss_4/users_grad/Reshape_1Reshapeplaceholders_2/sampled_users(gradients_2/loss_4/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
q
!gradients_2/loss_4/sub_grad/ShapeShapeloss_4/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_2/loss_4/sub_grad/Shape_1Shapeloss_4/neg_items*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_2/loss_4/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/sub_grad/Shape#gradients_2/loss_4/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_2/loss_4/sub_grad/SumSum6gradients_2/loss_4/mul_grad/tuple/control_dependency_11gradients_2/loss_4/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_2/loss_4/sub_grad/ReshapeReshapegradients_2/loss_4/sub_grad/Sum!gradients_2/loss_4/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
’
!gradients_2/loss_4/sub_grad/Sum_1Sum6gradients_2/loss_4/mul_grad/tuple/control_dependency_13gradients_2/loss_4/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_2/loss_4/sub_grad/NegNeg!gradients_2/loss_4/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_2/loss_4/sub_grad/Reshape_1Reshapegradients_2/loss_4/sub_grad/Neg#gradients_2/loss_4/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_2/loss_4/sub_grad/tuple/group_depsNoOp$^gradients_2/loss_4/sub_grad/Reshape&^gradients_2/loss_4/sub_grad/Reshape_1
ю
4gradients_2/loss_4/sub_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/sub_grad/Reshape-^gradients_2/loss_4/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_2/loss_4/sub_grad/Reshape
Д
6gradients_2/loss_4/sub_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/sub_grad/Reshape_1-^gradients_2/loss_4/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/sub_grad/Reshape_1
э
gradients_2/AddN_3AddN6gradients_2/loss_4/pow_1_grad/tuple/control_dependency4gradients_2/loss_4/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_1_grad/Reshape
•
'gradients_2/loss_4/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_2/item_factors
Б
&gradients_2/loss_4/pos_items_grad/SizeSize placeholders_2/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_2/loss_4/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_2/loss_4/pos_items_grad/ExpandDims
ExpandDims&gradients_2/loss_4/pos_items_grad/Size0gradients_2/loss_4/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_2/loss_4/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_2/loss_4/pos_items_grad/strided_sliceStridedSlice'gradients_2/loss_4/pos_items_grad/Shape5gradients_2/loss_4/pos_items_grad/strided_slice/stack7gradients_2/loss_4/pos_items_grad/strided_slice/stack_17gradients_2/loss_4/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_2/loss_4/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_2/loss_4/pos_items_grad/concatConcatV2,gradients_2/loss_4/pos_items_grad/ExpandDims/gradients_2/loss_4/pos_items_grad/strided_slice-gradients_2/loss_4/pos_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_2/loss_4/pos_items_grad/ReshapeReshapegradients_2/AddN_3(gradients_2/loss_4/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_2/loss_4/pos_items_grad/Reshape_1Reshape placeholders_2/sampled_pos_items,gradients_2/loss_4/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
€
gradients_2/AddN_4AddN6gradients_2/loss_4/pow_3_grad/tuple/control_dependency6gradients_2/loss_4/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_3_grad/Reshape
•
'gradients_2/loss_4/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_2/item_factors
Б
&gradients_2/loss_4/neg_items_grad/SizeSize placeholders_2/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_2/loss_4/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_2/loss_4/neg_items_grad/ExpandDims
ExpandDims&gradients_2/loss_4/neg_items_grad/Size0gradients_2/loss_4/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_2/loss_4/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_2/loss_4/neg_items_grad/strided_sliceStridedSlice'gradients_2/loss_4/neg_items_grad/Shape5gradients_2/loss_4/neg_items_grad/strided_slice/stack7gradients_2/loss_4/neg_items_grad/strided_slice/stack_17gradients_2/loss_4/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_2/loss_4/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_2/loss_4/neg_items_grad/concatConcatV2,gradients_2/loss_4/neg_items_grad/ExpandDims/gradients_2/loss_4/neg_items_grad/strided_slice-gradients_2/loss_4/neg_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_2/loss_4/neg_items_grad/ReshapeReshapegradients_2/AddN_4(gradients_2/loss_4/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_2/loss_4/neg_items_grad/Reshape_1Reshape placeholders_2/sampled_neg_items,gradients_2/loss_4/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
[
gradients_2/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_2/concat_2ConcatV2)gradients_2/loss_4/pos_items_grad/Reshape)gradients_2/loss_4/neg_items_grad/Reshapegradients_2/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_2/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_2/concat_3ConcatV2+gradients_2/loss_4/pos_items_grad/Reshape_1+gradients_2/loss_4/neg_items_grad/Reshape_1gradients_2/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
d
GradientDescent_2/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_2/update_variables_2/user_factors/mulMul%gradients_2/loss_4/users_grad/ReshapeGradientDescent_2/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_2/user_factors
Њ
<GradientDescent_2/update_variables_2/user_factors/ScatterSub
ScatterSubvariables_2/user_factors'gradients_2/loss_4/users_grad/Reshape_15GradientDescent_2/update_variables_2/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_2/user_factors
џ
5GradientDescent_2/update_variables_2/item_factors/mulMulgradients_2/concat_2GradientDescent_2/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_2/item_factors
Ђ
<GradientDescent_2/update_variables_2/item_factors/ScatterSub
ScatterSubvariables_2/item_factorsgradients_2/concat_35GradientDescent_2/update_variables_2/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_2/item_factors
∆
2GradientDescent_2/update_variables_2/item_bias/mulMulgradients_2/concatGradientDescent_2/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_2/item_bias
Ы
9GradientDescent_2/update_variables_2/item_bias/ScatterSub
ScatterSubvariables_2/item_biasgradients_2/concat_12GradientDescent_2/update_variables_2/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_2/item_bias
”
GradientDescent_2NoOp=^GradientDescent_2/update_variables_2/user_factors/ScatterSub=^GradientDescent_2/update_variables_2/item_factors/ScatterSub:^GradientDescent_2/update_variables_2/item_bias/ScatterSub
R
loss_5/tagsConst*
valueB Bloss_5*
_output_shapes
: *
dtype0
S
loss_5ScalarSummaryloss_5/tagsloss_4/sub_2*
_output_shapes
: *
T0
]
Merge_2/MergeSummaryMergeSummaryloss_1loss_3loss_5*
_output_shapes
: *
N
±
init_2NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign ^variables_2/user_factors/Assign ^variables_2/item_factors/Assign^variables_2/item_bias/Assign
j
placeholders_3/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_3/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_3/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_3/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_3/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_3/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_3/truncated_normal/TruncatedNormalTruncatedNormal"variables_3/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_3/truncated_normal/mulMul,variables_3/truncated_normal/TruncatedNormal#variables_3/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_3/truncated_normalAdd variables_3/truncated_normal/mul!variables_3/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_3/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_3/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_3/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_3/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_3/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_3/truncated_normal_1/mulMul.variables_3/truncated_normal_1/TruncatedNormal%variables_3/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_3/truncated_normal_1Add"variables_3/truncated_normal_1/mul#variables_3/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_3/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_3/user_factors/AssignAssignvariables_3/user_factorsvariables_3/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_3/user_factors
Ъ
variables_3/user_factors/readIdentityvariables_3/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_3/user_factors
О
variables_3/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_3/item_factors/AssignAssignvariables_3/item_factorsvariables_3/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_3/item_factors
Ъ
variables_3/item_factors/readIdentityvariables_3/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_3/item_factors
`
variables_3/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_3/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_3/item_bias/AssignAssignvariables_3/item_biasvariables_3/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_3/item_bias
Н
variables_3/item_bias/readIdentityvariables_3/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_3/item_bias
≥
loss_6/usersGathervariables_3/user_factors/readplaceholders_3/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_6/pos_itemsGathervariables_3/item_factors/read placeholders_3/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_6/neg_itemsGathervariables_3/item_factors/read placeholders_3/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_6/pos_item_biasGathervariables_3/item_bias/read placeholders_3/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_6/neg_item_biasGathervariables_3/item_bias/read placeholders_3/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_6/subSubloss_6/pos_itemsloss_6/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_6/mulMulloss_6/users
loss_6/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_6/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_6/SumSum
loss_6/mulloss_6/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_6/sub_1Subloss_6/pos_item_biasloss_6/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_6/addAddloss_6/sub_1
loss_6/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_6/SigmoidSigmoid
loss_6/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_6/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_6/clip_by_value/MinimumMinimumloss_6/Sigmoidloss_6/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_6/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_6/clip_by_valueMaximumloss_6/clip_by_value/Minimumloss_6/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_6/LogLogloss_6/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_6/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_6/Sum_1Sum
loss_6/Logloss_6/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_6/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_6/powPowloss_6/usersloss_6/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_6/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_6/Sum_2Sum
loss_6/powloss_6/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_6/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_6/mul_1Mulloss_6/mul_1/xloss_6/Sum_2*
_output_shapes
: *
T0
S
loss_6/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_1Powloss_6/pos_itemsloss_6/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_6/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_6/Sum_3Sumloss_6/pow_1loss_6/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_6/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_6/mul_2Mulloss_6/mul_2/xloss_6/Sum_3*
_output_shapes
: *
T0
S
loss_6/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_2Powloss_6/pos_item_biasloss_6/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_6/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_6/Sum_4Sumloss_6/pow_2loss_6/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_6/add_1Addloss_6/mul_2loss_6/Sum_4*
_output_shapes
: *
T0
S
loss_6/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_3Powloss_6/neg_itemsloss_6/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_6/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_6/Sum_5Sumloss_6/pow_3loss_6/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_6/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_6/mul_3Mulloss_6/mul_3/xloss_6/Sum_5*
_output_shapes
: *
T0
S
loss_6/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_4Powloss_6/neg_item_biasloss_6/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_6/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_6/Sum_6Sumloss_6/pow_4loss_6/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_6/add_2Addloss_6/mul_3loss_6/Sum_6*
_output_shapes
: *
T0
P
loss_6/add_3Addloss_6/mul_1loss_6/add_1*
_output_shapes
: *
T0
P
loss_6/add_4Addloss_6/add_3loss_6/add_2*
_output_shapes
: *
T0
P
loss_6/sub_2Subloss_6/add_4loss_6/Sum_1*
_output_shapes
: *
T0
T
gradients_3/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_3/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_3/FillFillgradients_3/Shapegradients_3/Const*
_output_shapes
: *
T0
f
#gradients_3/loss_6/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/sub_2_grad/Shape%gradients_3/loss_6/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_3/loss_6/sub_2_grad/SumSumgradients_3/Fill3gradients_3/loss_6/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/sub_2_grad/ReshapeReshape!gradients_3/loss_6/sub_2_grad/Sum#gradients_3/loss_6/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
≥
#gradients_3/loss_6/sub_2_grad/Sum_1Sumgradients_3/Fill5gradients_3/loss_6/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_3/loss_6/sub_2_grad/NegNeg#gradients_3/loss_6/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_3/loss_6/sub_2_grad/Reshape_1Reshape!gradients_3/loss_6/sub_2_grad/Neg%gradients_3/loss_6/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/sub_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/sub_2_grad/Reshape(^gradients_3/loss_6/sub_2_grad/Reshape_1
х
6gradients_3/loss_6/sub_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/sub_2_grad/Reshape/^gradients_3/loss_6/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/sub_2_grad/Reshape
ы
8gradients_3/loss_6/sub_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/sub_2_grad/Reshape_1/^gradients_3/loss_6/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/sub_2_grad/Reshape_1
f
#gradients_3/loss_6/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_4_grad/Shape%gradients_3/loss_6/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_3/loss_6/add_4_grad/SumSum6gradients_3/loss_6/sub_2_grad/tuple/control_dependency3gradients_3/loss_6/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_4_grad/ReshapeReshape!gradients_3/loss_6/add_4_grad/Sum#gradients_3/loss_6/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_3/loss_6/add_4_grad/Sum_1Sum6gradients_3/loss_6/sub_2_grad/tuple/control_dependency5gradients_3/loss_6/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_4_grad/Reshape_1Reshape#gradients_3/loss_6/add_4_grad/Sum_1%gradients_3/loss_6/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/add_4_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_4_grad/Reshape(^gradients_3/loss_6/add_4_grad/Reshape_1
х
6gradients_3/loss_6/add_4_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_4_grad/Reshape/^gradients_3/loss_6/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_4_grad/Reshape
ы
8gradients_3/loss_6/add_4_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_4_grad/Reshape_1/^gradients_3/loss_6/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_4_grad/Reshape_1
u
+gradients_3/loss_6/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_3/loss_6/Sum_1_grad/ReshapeReshape8gradients_3/loss_6/sub_2_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
m
#gradients_3/loss_6/Sum_1_grad/ShapeShape
loss_6/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_3/loss_6/Sum_1_grad/TileTile%gradients_3/loss_6/Sum_1_grad/Reshape#gradients_3/loss_6/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_3/loss_6/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_3_grad/Shape%gradients_3/loss_6/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_3/loss_6/add_3_grad/SumSum6gradients_3/loss_6/add_4_grad/tuple/control_dependency3gradients_3/loss_6/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_3_grad/ReshapeReshape!gradients_3/loss_6/add_3_grad/Sum#gradients_3/loss_6/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_3/loss_6/add_3_grad/Sum_1Sum6gradients_3/loss_6/add_4_grad/tuple/control_dependency5gradients_3/loss_6/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_3_grad/Reshape_1Reshape#gradients_3/loss_6/add_3_grad/Sum_1%gradients_3/loss_6/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/add_3_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_3_grad/Reshape(^gradients_3/loss_6/add_3_grad/Reshape_1
х
6gradients_3/loss_6/add_3_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_3_grad/Reshape/^gradients_3/loss_6/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_3_grad/Reshape
ы
8gradients_3/loss_6/add_3_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_3_grad/Reshape_1/^gradients_3/loss_6/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_3_grad/Reshape_1
f
#gradients_3/loss_6/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_2_grad/Shape%gradients_3/loss_6/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_3/loss_6/add_2_grad/SumSum8gradients_3/loss_6/add_4_grad/tuple/control_dependency_13gradients_3/loss_6/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_2_grad/ReshapeReshape!gradients_3/loss_6/add_2_grad/Sum#gradients_3/loss_6/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_3/loss_6/add_2_grad/Sum_1Sum8gradients_3/loss_6/add_4_grad/tuple/control_dependency_15gradients_3/loss_6/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_2_grad/Reshape_1Reshape#gradients_3/loss_6/add_2_grad/Sum_1%gradients_3/loss_6/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/add_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_2_grad/Reshape(^gradients_3/loss_6/add_2_grad/Reshape_1
х
6gradients_3/loss_6/add_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_2_grad/Reshape/^gradients_3/loss_6/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_2_grad/Reshape
ы
8gradients_3/loss_6/add_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_2_grad/Reshape_1/^gradients_3/loss_6/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_2_grad/Reshape_1
Э
&gradients_3/loss_6/Log_grad/Reciprocal
Reciprocalloss_6/clip_by_value#^gradients_3/loss_6/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_3/loss_6/Log_grad/mulMul"gradients_3/loss_6/Sum_1_grad/Tile&gradients_3/loss_6/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_3/loss_6/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/mul_1_grad/Shape%gradients_3/loss_6/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_3/loss_6/mul_1_grad/mulMul6gradients_3/loss_6/add_3_grad/tuple/control_dependencyloss_6/Sum_2*
_output_shapes
: *
T0
ј
!gradients_3/loss_6/mul_1_grad/SumSum!gradients_3/loss_6/mul_1_grad/mul3gradients_3/loss_6/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/mul_1_grad/ReshapeReshape!gradients_3/loss_6/mul_1_grad/Sum#gradients_3/loss_6/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_3/loss_6/mul_1_grad/mul_1Mulloss_6/mul_1/x6gradients_3/loss_6/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_3/loss_6/mul_1_grad/Sum_1Sum#gradients_3/loss_6/mul_1_grad/mul_15gradients_3/loss_6/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/mul_1_grad/Reshape_1Reshape#gradients_3/loss_6/mul_1_grad/Sum_1%gradients_3/loss_6/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/mul_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/mul_1_grad/Reshape(^gradients_3/loss_6/mul_1_grad/Reshape_1
х
6gradients_3/loss_6/mul_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/mul_1_grad/Reshape/^gradients_3/loss_6/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_1_grad/Reshape
ы
8gradients_3/loss_6/mul_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/mul_1_grad/Reshape_1/^gradients_3/loss_6/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/mul_1_grad/Reshape_1
f
#gradients_3/loss_6/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_1_grad/Shape%gradients_3/loss_6/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_3/loss_6/add_1_grad/SumSum8gradients_3/loss_6/add_3_grad/tuple/control_dependency_13gradients_3/loss_6/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_1_grad/ReshapeReshape!gradients_3/loss_6/add_1_grad/Sum#gradients_3/loss_6/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_3/loss_6/add_1_grad/Sum_1Sum8gradients_3/loss_6/add_3_grad/tuple/control_dependency_15gradients_3/loss_6/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_1_grad/Reshape_1Reshape#gradients_3/loss_6/add_1_grad/Sum_1%gradients_3/loss_6/add_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/add_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_1_grad/Reshape(^gradients_3/loss_6/add_1_grad/Reshape_1
х
6gradients_3/loss_6/add_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_1_grad/Reshape/^gradients_3/loss_6/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_1_grad/Reshape
ы
8gradients_3/loss_6/add_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_1_grad/Reshape_1/^gradients_3/loss_6/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_1_grad/Reshape_1
f
#gradients_3/loss_6/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/mul_3_grad/Shape%gradients_3/loss_6/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_3/loss_6/mul_3_grad/mulMul6gradients_3/loss_6/add_2_grad/tuple/control_dependencyloss_6/Sum_5*
_output_shapes
: *
T0
ј
!gradients_3/loss_6/mul_3_grad/SumSum!gradients_3/loss_6/mul_3_grad/mul3gradients_3/loss_6/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/mul_3_grad/ReshapeReshape!gradients_3/loss_6/mul_3_grad/Sum#gradients_3/loss_6/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_3/loss_6/mul_3_grad/mul_1Mulloss_6/mul_3/x6gradients_3/loss_6/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_3/loss_6/mul_3_grad/Sum_1Sum#gradients_3/loss_6/mul_3_grad/mul_15gradients_3/loss_6/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/mul_3_grad/Reshape_1Reshape#gradients_3/loss_6/mul_3_grad/Sum_1%gradients_3/loss_6/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/mul_3_grad/tuple/group_depsNoOp&^gradients_3/loss_6/mul_3_grad/Reshape(^gradients_3/loss_6/mul_3_grad/Reshape_1
х
6gradients_3/loss_6/mul_3_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/mul_3_grad/Reshape/^gradients_3/loss_6/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_3_grad/Reshape
ы
8gradients_3/loss_6/mul_3_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/mul_3_grad/Reshape_1/^gradients_3/loss_6/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/mul_3_grad/Reshape_1
u
+gradients_3/loss_6/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_3/loss_6/Sum_6_grad/ReshapeReshape8gradients_3/loss_6/add_2_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_6_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_3/loss_6/Sum_6_grad/ShapeShapeloss_6/pow_4*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_3/loss_6/Sum_6_grad/TileTile%gradients_3/loss_6/Sum_6_grad/Reshape#gradients_3/loss_6/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_3/loss_6/clip_by_value_grad/ShapeShapeloss_6/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_3/loss_6/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_3/loss_6/clip_by_value_grad/Shape_2Shapegradients_3/loss_6/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_3/loss_6/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_3/loss_6/clip_by_value_grad/zerosFill-gradients_3/loss_6/clip_by_value_grad/Shape_21gradients_3/loss_6/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_3/loss_6/clip_by_value_grad/GreaterEqualGreaterEqualloss_6/clip_by_value/Minimumloss_6/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_3/loss_6/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_3/loss_6/clip_by_value_grad/Shape-gradients_3/loss_6/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_3/loss_6/clip_by_value_grad/SelectSelect2gradients_3/loss_6/clip_by_value_grad/GreaterEqualgradients_3/loss_6/Log_grad/mul+gradients_3/loss_6/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_3/loss_6/clip_by_value_grad/LogicalNot
LogicalNot2gradients_3/loss_6/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_3/loss_6/clip_by_value_grad/Select_1Select0gradients_3/loss_6/clip_by_value_grad/LogicalNotgradients_3/loss_6/Log_grad/mul+gradients_3/loss_6/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_3/loss_6/clip_by_value_grad/SumSum,gradients_3/loss_6/clip_by_value_grad/Select;gradients_3/loss_6/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_3/loss_6/clip_by_value_grad/ReshapeReshape)gradients_3/loss_6/clip_by_value_grad/Sum+gradients_3/loss_6/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
б
+gradients_3/loss_6/clip_by_value_grad/Sum_1Sum.gradients_3/loss_6/clip_by_value_grad/Select_1=gradients_3/loss_6/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_3/loss_6/clip_by_value_grad/Reshape_1Reshape+gradients_3/loss_6/clip_by_value_grad/Sum_1-gradients_3/loss_6/clip_by_value_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
†
6gradients_3/loss_6/clip_by_value_grad/tuple/group_depsNoOp.^gradients_3/loss_6/clip_by_value_grad/Reshape0^gradients_3/loss_6/clip_by_value_grad/Reshape_1
Ґ
>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_3/loss_6/clip_by_value_grad/Reshape7^gradients_3/loss_6/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_3/loss_6/clip_by_value_grad/Reshape
Ы
@gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_3/loss_6/clip_by_value_grad/Reshape_17^gradients_3/loss_6/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_3/loss_6/clip_by_value_grad/Reshape_1
|
+gradients_3/loss_6/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_3/loss_6/Sum_2_grad/ReshapeReshape8gradients_3/loss_6/mul_1_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_2_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
m
#gradients_3/loss_6/Sum_2_grad/ShapeShape
loss_6/pow*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_3/loss_6/Sum_2_grad/TileTile%gradients_3/loss_6/Sum_2_grad/Reshape#gradients_3/loss_6/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_3/loss_6/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/mul_2_grad/Shape%gradients_3/loss_6/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_3/loss_6/mul_2_grad/mulMul6gradients_3/loss_6/add_1_grad/tuple/control_dependencyloss_6/Sum_3*
_output_shapes
: *
T0
ј
!gradients_3/loss_6/mul_2_grad/SumSum!gradients_3/loss_6/mul_2_grad/mul3gradients_3/loss_6/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/mul_2_grad/ReshapeReshape!gradients_3/loss_6/mul_2_grad/Sum#gradients_3/loss_6/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_3/loss_6/mul_2_grad/mul_1Mulloss_6/mul_2/x6gradients_3/loss_6/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_3/loss_6/mul_2_grad/Sum_1Sum#gradients_3/loss_6/mul_2_grad/mul_15gradients_3/loss_6/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/mul_2_grad/Reshape_1Reshape#gradients_3/loss_6/mul_2_grad/Sum_1%gradients_3/loss_6/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/mul_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/mul_2_grad/Reshape(^gradients_3/loss_6/mul_2_grad/Reshape_1
х
6gradients_3/loss_6/mul_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/mul_2_grad/Reshape/^gradients_3/loss_6/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_2_grad/Reshape
ы
8gradients_3/loss_6/mul_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/mul_2_grad/Reshape_1/^gradients_3/loss_6/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/mul_2_grad/Reshape_1
u
+gradients_3/loss_6/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_3/loss_6/Sum_4_grad/ReshapeReshape8gradients_3/loss_6/add_1_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_4_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_3/loss_6/Sum_4_grad/ShapeShapeloss_6/pow_2*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_3/loss_6/Sum_4_grad/TileTile%gradients_3/loss_6/Sum_4_grad/Reshape#gradients_3/loss_6/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_3/loss_6/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_3/loss_6/Sum_5_grad/ReshapeReshape8gradients_3/loss_6/mul_3_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_5_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_3/loss_6/Sum_5_grad/ShapeShapeloss_6/pow_3*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_3/loss_6/Sum_5_grad/TileTile%gradients_3/loss_6/Sum_5_grad/Reshape#gradients_3/loss_6/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_3/loss_6/pow_4_grad/ShapeShapeloss_6/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_4_grad/Shape%gradients_3/loss_6/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_3/loss_6/pow_4_grad/mulMul"gradients_3/loss_6/Sum_6_grad/Tileloss_6/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_3/loss_6/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_4_grad/subSubloss_6/pow_4/y#gradients_3/loss_6/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_4_grad/PowPowloss_6/neg_item_bias!gradients_3/loss_6/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_3/loss_6/pow_4_grad/mul_1Mul!gradients_3/loss_6/pow_4_grad/mul!gradients_3/loss_6/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_3/loss_6/pow_4_grad/SumSum#gradients_3/loss_6/pow_4_grad/mul_13gradients_3/loss_6/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/pow_4_grad/ReshapeReshape!gradients_3/loss_6/pow_4_grad/Sum#gradients_3/loss_6/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_3/loss_6/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_4_grad/GreaterGreaterloss_6/neg_item_bias'gradients_3/loss_6/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_3/loss_6/pow_4_grad/LogLogloss_6/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_3/loss_6/pow_4_grad/zeros_like	ZerosLikeloss_6/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_3/loss_6/pow_4_grad/SelectSelect%gradients_3/loss_6/pow_4_grad/Greater!gradients_3/loss_6/pow_4_grad/Log(gradients_3/loss_6/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_3/loss_6/pow_4_grad/mul_2Mul"gradients_3/loss_6/Sum_6_grad/Tileloss_6/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_3/loss_6/pow_4_grad/mul_3Mul#gradients_3/loss_6/pow_4_grad/mul_2$gradients_3/loss_6/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_3/loss_6/pow_4_grad/Sum_1Sum#gradients_3/loss_6/pow_4_grad/mul_35gradients_3/loss_6/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_4_grad/Reshape_1Reshape#gradients_3/loss_6/pow_4_grad/Sum_1%gradients_3/loss_6/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/pow_4_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_4_grad/Reshape(^gradients_3/loss_6/pow_4_grad/Reshape_1
В
6gradients_3/loss_6/pow_4_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_4_grad/Reshape/^gradients_3/loss_6/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_4_grad/Reshape
ы
8gradients_3/loss_6/pow_4_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_4_grad/Reshape_1/^gradients_3/loss_6/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_4_grad/Reshape_1
Б
3gradients_3/loss_6/clip_by_value/Minimum_grad/ShapeShapeloss_6/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_2Shape>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_3/loss_6/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_3/loss_6/clip_by_value/Minimum_grad/zerosFill5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_29gradients_3/loss_6/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_3/loss_6/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_6/Sigmoidloss_6/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_3/loss_6/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_3/loss_6/clip_by_value/Minimum_grad/Shape5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_3/loss_6/clip_by_value/Minimum_grad/SelectSelect7gradients_3/loss_6/clip_by_value/Minimum_grad/LessEqual>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency3gradients_3/loss_6/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_3/loss_6/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_3/loss_6/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_3/loss_6/clip_by_value/Minimum_grad/Select_1Select8gradients_3/loss_6/clip_by_value/Minimum_grad/LogicalNot>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency3gradients_3/loss_6/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_3/loss_6/clip_by_value/Minimum_grad/SumSum4gradients_3/loss_6/clip_by_value/Minimum_grad/SelectCgradients_3/loss_6/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_3/loss_6/clip_by_value/Minimum_grad/ReshapeReshape1gradients_3/loss_6/clip_by_value/Minimum_grad/Sum3gradients_3/loss_6/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
щ
3gradients_3/loss_6/clip_by_value/Minimum_grad/Sum_1Sum6gradients_3/loss_6/clip_by_value/Minimum_grad/Select_1Egradients_3/loss_6/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_3/loss_6/clip_by_value/Minimum_grad/Sum_15gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
Є
>gradients_3/loss_6/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape8^gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_3/loss_6/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape?^gradients_3/loss_6/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_3/loss_6/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1?^gradients_3/loss_6/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_3/loss_6/pow_grad/ShapeShapeloss_6/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_3/loss_6/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_3/loss_6/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/pow_grad/Shape#gradients_3/loss_6/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_3/loss_6/pow_grad/mulMul"gradients_3/loss_6/Sum_2_grad/Tileloss_6/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_3/loss_6/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_3/loss_6/pow_grad/subSubloss_6/pow/y!gradients_3/loss_6/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_3/loss_6/pow_grad/PowPowloss_6/usersgradients_3/loss_6/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_3/loss_6/pow_grad/mul_1Mulgradients_3/loss_6/pow_grad/mulgradients_3/loss_6/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_3/loss_6/pow_grad/SumSum!gradients_3/loss_6/pow_grad/mul_11gradients_3/loss_6/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_3/loss_6/pow_grad/ReshapeReshapegradients_3/loss_6/pow_grad/Sum!gradients_3/loss_6/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
j
%gradients_3/loss_6/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_3/loss_6/pow_grad/GreaterGreaterloss_6/users%gradients_3/loss_6/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_3/loss_6/pow_grad/LogLogloss_6/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_3/loss_6/pow_grad/zeros_like	ZerosLikeloss_6/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_3/loss_6/pow_grad/SelectSelect#gradients_3/loss_6/pow_grad/Greatergradients_3/loss_6/pow_grad/Log&gradients_3/loss_6/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_3/loss_6/pow_grad/mul_2Mul"gradients_3/loss_6/Sum_2_grad/Tile
loss_6/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_3/loss_6/pow_grad/mul_3Mul!gradients_3/loss_6/pow_grad/mul_2"gradients_3/loss_6/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_3/loss_6/pow_grad/Sum_1Sum!gradients_3/loss_6/pow_grad/mul_33gradients_3/loss_6/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/pow_grad/Reshape_1Reshape!gradients_3/loss_6/pow_grad/Sum_1#gradients_3/loss_6/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
В
,gradients_3/loss_6/pow_grad/tuple/group_depsNoOp$^gradients_3/loss_6/pow_grad/Reshape&^gradients_3/loss_6/pow_grad/Reshape_1
ю
4gradients_3/loss_6/pow_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/pow_grad/Reshape-^gradients_3/loss_6/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_3/loss_6/pow_grad/Reshape
у
6gradients_3/loss_6/pow_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/pow_grad/Reshape_1-^gradients_3/loss_6/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_grad/Reshape_1
|
+gradients_3/loss_6/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_3/loss_6/Sum_3_grad/ReshapeReshape8gradients_3/loss_6/mul_2_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_3_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_3/loss_6/Sum_3_grad/ShapeShapeloss_6/pow_1*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_3/loss_6/Sum_3_grad/TileTile%gradients_3/loss_6/Sum_3_grad/Reshape#gradients_3/loss_6/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_3/loss_6/pow_2_grad/ShapeShapeloss_6/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_2_grad/Shape%gradients_3/loss_6/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_3/loss_6/pow_2_grad/mulMul"gradients_3/loss_6/Sum_4_grad/Tileloss_6/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_3/loss_6/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_2_grad/subSubloss_6/pow_2/y#gradients_3/loss_6/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_2_grad/PowPowloss_6/pos_item_bias!gradients_3/loss_6/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_3/loss_6/pow_2_grad/mul_1Mul!gradients_3/loss_6/pow_2_grad/mul!gradients_3/loss_6/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_3/loss_6/pow_2_grad/SumSum#gradients_3/loss_6/pow_2_grad/mul_13gradients_3/loss_6/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/pow_2_grad/ReshapeReshape!gradients_3/loss_6/pow_2_grad/Sum#gradients_3/loss_6/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_3/loss_6/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_2_grad/GreaterGreaterloss_6/pos_item_bias'gradients_3/loss_6/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_3/loss_6/pow_2_grad/LogLogloss_6/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_3/loss_6/pow_2_grad/zeros_like	ZerosLikeloss_6/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_3/loss_6/pow_2_grad/SelectSelect%gradients_3/loss_6/pow_2_grad/Greater!gradients_3/loss_6/pow_2_grad/Log(gradients_3/loss_6/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_3/loss_6/pow_2_grad/mul_2Mul"gradients_3/loss_6/Sum_4_grad/Tileloss_6/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_3/loss_6/pow_2_grad/mul_3Mul#gradients_3/loss_6/pow_2_grad/mul_2$gradients_3/loss_6/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_3/loss_6/pow_2_grad/Sum_1Sum#gradients_3/loss_6/pow_2_grad/mul_35gradients_3/loss_6/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_2_grad/Reshape_1Reshape#gradients_3/loss_6/pow_2_grad/Sum_1%gradients_3/loss_6/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/pow_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_2_grad/Reshape(^gradients_3/loss_6/pow_2_grad/Reshape_1
В
6gradients_3/loss_6/pow_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_2_grad/Reshape/^gradients_3/loss_6/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_2_grad/Reshape
ы
8gradients_3/loss_6/pow_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_2_grad/Reshape_1/^gradients_3/loss_6/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_2_grad/Reshape_1
s
#gradients_3/loss_6/pow_3_grad/ShapeShapeloss_6/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_3_grad/Shape%gradients_3/loss_6/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_3/loss_6/pow_3_grad/mulMul"gradients_3/loss_6/Sum_5_grad/Tileloss_6/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_3/loss_6/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_3_grad/subSubloss_6/pow_3/y#gradients_3/loss_6/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_3_grad/PowPowloss_6/neg_items!gradients_3/loss_6/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_3/loss_6/pow_3_grad/mul_1Mul!gradients_3/loss_6/pow_3_grad/mul!gradients_3/loss_6/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_3/loss_6/pow_3_grad/SumSum#gradients_3/loss_6/pow_3_grad/mul_13gradients_3/loss_6/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_3/loss_6/pow_3_grad/ReshapeReshape!gradients_3/loss_6/pow_3_grad/Sum#gradients_3/loss_6/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_3/loss_6/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_3_grad/GreaterGreaterloss_6/neg_items'gradients_3/loss_6/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_3/loss_6/pow_3_grad/LogLogloss_6/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_3/loss_6/pow_3_grad/zeros_like	ZerosLikeloss_6/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_3/loss_6/pow_3_grad/SelectSelect%gradients_3/loss_6/pow_3_grad/Greater!gradients_3/loss_6/pow_3_grad/Log(gradients_3/loss_6/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_3/loss_6/pow_3_grad/mul_2Mul"gradients_3/loss_6/Sum_5_grad/Tileloss_6/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_3/loss_6/pow_3_grad/mul_3Mul#gradients_3/loss_6/pow_3_grad/mul_2$gradients_3/loss_6/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_3/loss_6/pow_3_grad/Sum_1Sum#gradients_3/loss_6/pow_3_grad/mul_35gradients_3/loss_6/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_3_grad/Reshape_1Reshape#gradients_3/loss_6/pow_3_grad/Sum_1%gradients_3/loss_6/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/pow_3_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_3_grad/Reshape(^gradients_3/loss_6/pow_3_grad/Reshape_1
Ж
6gradients_3/loss_6/pow_3_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_3_grad/Reshape/^gradients_3/loss_6/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_3_grad/Reshape
ы
8gradients_3/loss_6/pow_3_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_3_grad/Reshape_1/^gradients_3/loss_6/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_3_grad/Reshape_1
ј
+gradients_3/loss_6/Sigmoid_grad/SigmoidGradSigmoidGradloss_6/SigmoidFgradients_3/loss_6/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_3/loss_6/pow_1_grad/ShapeShapeloss_6/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_1_grad/Shape%gradients_3/loss_6/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_3/loss_6/pow_1_grad/mulMul"gradients_3/loss_6/Sum_3_grad/Tileloss_6/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_3/loss_6/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_1_grad/subSubloss_6/pow_1/y#gradients_3/loss_6/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_1_grad/PowPowloss_6/pos_items!gradients_3/loss_6/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_3/loss_6/pow_1_grad/mul_1Mul!gradients_3/loss_6/pow_1_grad/mul!gradients_3/loss_6/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_3/loss_6/pow_1_grad/SumSum#gradients_3/loss_6/pow_1_grad/mul_13gradients_3/loss_6/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_3/loss_6/pow_1_grad/ReshapeReshape!gradients_3/loss_6/pow_1_grad/Sum#gradients_3/loss_6/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_3/loss_6/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_1_grad/GreaterGreaterloss_6/pos_items'gradients_3/loss_6/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_3/loss_6/pow_1_grad/LogLogloss_6/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_3/loss_6/pow_1_grad/zeros_like	ZerosLikeloss_6/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_3/loss_6/pow_1_grad/SelectSelect%gradients_3/loss_6/pow_1_grad/Greater!gradients_3/loss_6/pow_1_grad/Log(gradients_3/loss_6/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_3/loss_6/pow_1_grad/mul_2Mul"gradients_3/loss_6/Sum_3_grad/Tileloss_6/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_3/loss_6/pow_1_grad/mul_3Mul#gradients_3/loss_6/pow_1_grad/mul_2$gradients_3/loss_6/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_3/loss_6/pow_1_grad/Sum_1Sum#gradients_3/loss_6/pow_1_grad/mul_35gradients_3/loss_6/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_1_grad/Reshape_1Reshape#gradients_3/loss_6/pow_1_grad/Sum_1%gradients_3/loss_6/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_3/loss_6/pow_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_1_grad/Reshape(^gradients_3/loss_6/pow_1_grad/Reshape_1
Ж
6gradients_3/loss_6/pow_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_1_grad/Reshape/^gradients_3/loss_6/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_1_grad/Reshape
ы
8gradients_3/loss_6/pow_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_1_grad/Reshape_1/^gradients_3/loss_6/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_1_grad/Reshape_1
m
!gradients_3/loss_6/add_grad/ShapeShapeloss_6/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_3/loss_6/add_grad/Shape_1Shape
loss_6/Sum*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_3/loss_6/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/add_grad/Shape#gradients_3/loss_6/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_3/loss_6/add_grad/SumSum+gradients_3/loss_6/Sigmoid_grad/SigmoidGrad1gradients_3/loss_6/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_3/loss_6/add_grad/ReshapeReshapegradients_3/loss_6/add_grad/Sum!gradients_3/loss_6/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
!gradients_3/loss_6/add_grad/Sum_1Sum+gradients_3/loss_6/Sigmoid_grad/SigmoidGrad3gradients_3/loss_6/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/add_grad/Reshape_1Reshape!gradients_3/loss_6/add_grad/Sum_1#gradients_3/loss_6/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
В
,gradients_3/loss_6/add_grad/tuple/group_depsNoOp$^gradients_3/loss_6/add_grad/Reshape&^gradients_3/loss_6/add_grad/Reshape_1
ъ
4gradients_3/loss_6/add_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/add_grad/Reshape-^gradients_3/loss_6/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_3/loss_6/add_grad/Reshape
А
6gradients_3/loss_6/add_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/add_grad/Reshape_1-^gradients_3/loss_6/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/add_grad/Reshape_1
w
#gradients_3/loss_6/sub_1_grad/ShapeShapeloss_6/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_3/loss_6/sub_1_grad/Shape_1Shapeloss_6/neg_item_bias*
_output_shapes
:*
T0*
out_type0
’
3gradients_3/loss_6/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/sub_1_grad/Shape%gradients_3/loss_6/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_3/loss_6/sub_1_grad/SumSum4gradients_3/loss_6/add_grad/tuple/control_dependency3gradients_3/loss_6/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/sub_1_grad/ReshapeReshape!gradients_3/loss_6/sub_1_grad/Sum#gradients_3/loss_6/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
„
#gradients_3/loss_6/sub_1_grad/Sum_1Sum4gradients_3/loss_6/add_grad/tuple/control_dependency5gradients_3/loss_6/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_3/loss_6/sub_1_grad/NegNeg#gradients_3/loss_6/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_3/loss_6/sub_1_grad/Reshape_1Reshape!gradients_3/loss_6/sub_1_grad/Neg%gradients_3/loss_6/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
И
.gradients_3/loss_6/sub_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/sub_1_grad/Reshape(^gradients_3/loss_6/sub_1_grad/Reshape_1
В
6gradients_3/loss_6/sub_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/sub_1_grad/Reshape/^gradients_3/loss_6/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/sub_1_grad/Reshape
И
8gradients_3/loss_6/sub_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/sub_1_grad/Reshape_1/^gradients_3/loss_6/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*:
_class0
.,loc:@gradients_3/loss_6/sub_1_grad/Reshape_1
k
!gradients_3/loss_6/Sum_grad/ShapeShape
loss_6/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_3/loss_6/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_3/loss_6/Sum_grad/addAddloss_6/Sum/reduction_indices gradients_3/loss_6/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_3/loss_6/Sum_grad/modFloorModgradients_3/loss_6/Sum_grad/add gradients_3/loss_6/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_3/loss_6/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_3/loss_6/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_3/loss_6/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_3/loss_6/Sum_grad/rangeRange'gradients_3/loss_6/Sum_grad/range/start gradients_3/loss_6/Sum_grad/Size'gradients_3/loss_6/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_3/loss_6/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_3/loss_6/Sum_grad/FillFill#gradients_3/loss_6/Sum_grad/Shape_1&gradients_3/loss_6/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_3/loss_6/Sum_grad/DynamicStitchDynamicStitch!gradients_3/loss_6/Sum_grad/rangegradients_3/loss_6/Sum_grad/mod!gradients_3/loss_6/Sum_grad/Shape gradients_3/loss_6/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
N*
T0
g
%gradients_3/loss_6/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_3/loss_6/Sum_grad/MaximumMaximum)gradients_3/loss_6/Sum_grad/DynamicStitch%gradients_3/loss_6/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_3/loss_6/Sum_grad/floordivFloorDiv!gradients_3/loss_6/Sum_grad/Shape#gradients_3/loss_6/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_3/loss_6/Sum_grad/ReshapeReshape6gradients_3/loss_6/add_grad/tuple/control_dependency_1)gradients_3/loss_6/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
Ј
 gradients_3/loss_6/Sum_grad/TileTile#gradients_3/loss_6/Sum_grad/Reshape$gradients_3/loss_6/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_3/AddNAddN6gradients_3/loss_6/pow_2_grad/tuple/control_dependency6gradients_3/loss_6/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_2_grad/Reshape
†
+gradients_3/loss_6/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_3/item_bias
Е
*gradients_3/loss_6/pos_item_bias_grad/SizeSize placeholders_3/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_3/loss_6/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_3/loss_6/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_3/loss_6/pos_item_bias_grad/Size4gradients_3/loss_6/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_3/loss_6/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_3/loss_6/pos_item_bias_grad/strided_sliceStridedSlice+gradients_3/loss_6/pos_item_bias_grad/Shape9gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_1;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_3/loss_6/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_3/loss_6/pos_item_bias_grad/concatConcatV20gradients_3/loss_6/pos_item_bias_grad/ExpandDims3gradients_3/loss_6/pos_item_bias_grad/strided_slice1gradients_3/loss_6/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
і
-gradients_3/loss_6/pos_item_bias_grad/ReshapeReshapegradients_3/AddN,gradients_3/loss_6/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_3/loss_6/pos_item_bias_grad/Reshape_1Reshape placeholders_3/sampled_pos_items0gradients_3/loss_6/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
э
gradients_3/AddN_1AddN6gradients_3/loss_6/pow_4_grad/tuple/control_dependency8gradients_3/loss_6/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_4_grad/Reshape
†
+gradients_3/loss_6/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_3/item_bias
Е
*gradients_3/loss_6/neg_item_bias_grad/SizeSize placeholders_3/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_3/loss_6/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_3/loss_6/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_3/loss_6/neg_item_bias_grad/Size4gradients_3/loss_6/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_3/loss_6/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_3/loss_6/neg_item_bias_grad/strided_sliceStridedSlice+gradients_3/loss_6/neg_item_bias_grad/Shape9gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_1;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_3/loss_6/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_3/loss_6/neg_item_bias_grad/concatConcatV20gradients_3/loss_6/neg_item_bias_grad/ExpandDims3gradients_3/loss_6/neg_item_bias_grad/strided_slice1gradients_3/loss_6/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ґ
-gradients_3/loss_6/neg_item_bias_grad/ReshapeReshapegradients_3/AddN_1,gradients_3/loss_6/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_3/loss_6/neg_item_bias_grad/Reshape_1Reshape placeholders_3/sampled_neg_items0gradients_3/loss_6/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
m
!gradients_3/loss_6/mul_grad/ShapeShapeloss_6/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_3/loss_6/mul_grad/Shape_1Shape
loss_6/sub*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_3/loss_6/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/mul_grad/Shape#gradients_3/loss_6/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_3/loss_6/mul_grad/mulMul gradients_3/loss_6/Sum_grad/Tile
loss_6/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_3/loss_6/mul_grad/SumSumgradients_3/loss_6/mul_grad/mul1gradients_3/loss_6/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_3/loss_6/mul_grad/ReshapeReshapegradients_3/loss_6/mul_grad/Sum!gradients_3/loss_6/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
К
!gradients_3/loss_6/mul_grad/mul_1Mulloss_6/users gradients_3/loss_6/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_3/loss_6/mul_grad/Sum_1Sum!gradients_3/loss_6/mul_grad/mul_13gradients_3/loss_6/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_3/loss_6/mul_grad/Reshape_1Reshape!gradients_3/loss_6/mul_grad/Sum_1#gradients_3/loss_6/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_3/loss_6/mul_grad/tuple/group_depsNoOp$^gradients_3/loss_6/mul_grad/Reshape&^gradients_3/loss_6/mul_grad/Reshape_1
ю
4gradients_3/loss_6/mul_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/mul_grad/Reshape-^gradients_3/loss_6/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_3/loss_6/mul_grad/Reshape
Д
6gradients_3/loss_6/mul_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/mul_grad/Reshape_1-^gradients_3/loss_6/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_grad/Reshape_1
Y
gradients_3/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_3/concatConcatV2-gradients_3/loss_6/pos_item_bias_grad/Reshape-gradients_3/loss_6/neg_item_bias_grad/Reshapegradients_3/concat/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_3/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_3/concat_1ConcatV2/gradients_3/loss_6/pos_item_bias_grad/Reshape_1/gradients_3/loss_6/neg_item_bias_grad/Reshape_1gradients_3/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
щ
gradients_3/AddN_2AddN4gradients_3/loss_6/pow_grad/tuple/control_dependency4gradients_3/loss_6/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*6
_class,
*(loc:@gradients_3/loss_6/pow_grad/Reshape
°
#gradients_3/loss_6/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_3/user_factors
y
"gradients_3/loss_6/users_grad/SizeSizeplaceholders_3/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_3/loss_6/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_3/loss_6/users_grad/ExpandDims
ExpandDims"gradients_3/loss_6/users_grad/Size,gradients_3/loss_6/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_3/loss_6/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_3/loss_6/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_3/loss_6/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_3/loss_6/users_grad/strided_sliceStridedSlice#gradients_3/loss_6/users_grad/Shape1gradients_3/loss_6/users_grad/strided_slice/stack3gradients_3/loss_6/users_grad/strided_slice/stack_13gradients_3/loss_6/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_3/loss_6/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_3/loss_6/users_grad/concatConcatV2(gradients_3/loss_6/users_grad/ExpandDims+gradients_3/loss_6/users_grad/strided_slice)gradients_3/loss_6/users_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
≥
%gradients_3/loss_6/users_grad/ReshapeReshapegradients_3/AddN_2$gradients_3/loss_6/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
ґ
'gradients_3/loss_6/users_grad/Reshape_1Reshapeplaceholders_3/sampled_users(gradients_3/loss_6/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
q
!gradients_3/loss_6/sub_grad/ShapeShapeloss_6/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_3/loss_6/sub_grad/Shape_1Shapeloss_6/neg_items*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_3/loss_6/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/sub_grad/Shape#gradients_3/loss_6/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_3/loss_6/sub_grad/SumSum6gradients_3/loss_6/mul_grad/tuple/control_dependency_11gradients_3/loss_6/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_3/loss_6/sub_grad/ReshapeReshapegradients_3/loss_6/sub_grad/Sum!gradients_3/loss_6/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
’
!gradients_3/loss_6/sub_grad/Sum_1Sum6gradients_3/loss_6/mul_grad/tuple/control_dependency_13gradients_3/loss_6/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_3/loss_6/sub_grad/NegNeg!gradients_3/loss_6/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_3/loss_6/sub_grad/Reshape_1Reshapegradients_3/loss_6/sub_grad/Neg#gradients_3/loss_6/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_3/loss_6/sub_grad/tuple/group_depsNoOp$^gradients_3/loss_6/sub_grad/Reshape&^gradients_3/loss_6/sub_grad/Reshape_1
ю
4gradients_3/loss_6/sub_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/sub_grad/Reshape-^gradients_3/loss_6/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_3/loss_6/sub_grad/Reshape
Д
6gradients_3/loss_6/sub_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/sub_grad/Reshape_1-^gradients_3/loss_6/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/sub_grad/Reshape_1
э
gradients_3/AddN_3AddN6gradients_3/loss_6/pow_1_grad/tuple/control_dependency4gradients_3/loss_6/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_1_grad/Reshape
•
'gradients_3/loss_6/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_3/item_factors
Б
&gradients_3/loss_6/pos_items_grad/SizeSize placeholders_3/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_3/loss_6/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_3/loss_6/pos_items_grad/ExpandDims
ExpandDims&gradients_3/loss_6/pos_items_grad/Size0gradients_3/loss_6/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_3/loss_6/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_3/loss_6/pos_items_grad/strided_sliceStridedSlice'gradients_3/loss_6/pos_items_grad/Shape5gradients_3/loss_6/pos_items_grad/strided_slice/stack7gradients_3/loss_6/pos_items_grad/strided_slice/stack_17gradients_3/loss_6/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_3/loss_6/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_3/loss_6/pos_items_grad/concatConcatV2,gradients_3/loss_6/pos_items_grad/ExpandDims/gradients_3/loss_6/pos_items_grad/strided_slice-gradients_3/loss_6/pos_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_3/loss_6/pos_items_grad/ReshapeReshapegradients_3/AddN_3(gradients_3/loss_6/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_3/loss_6/pos_items_grad/Reshape_1Reshape placeholders_3/sampled_pos_items,gradients_3/loss_6/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
€
gradients_3/AddN_4AddN6gradients_3/loss_6/pow_3_grad/tuple/control_dependency6gradients_3/loss_6/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_3_grad/Reshape
•
'gradients_3/loss_6/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_3/item_factors
Б
&gradients_3/loss_6/neg_items_grad/SizeSize placeholders_3/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_3/loss_6/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_3/loss_6/neg_items_grad/ExpandDims
ExpandDims&gradients_3/loss_6/neg_items_grad/Size0gradients_3/loss_6/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_3/loss_6/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_3/loss_6/neg_items_grad/strided_sliceStridedSlice'gradients_3/loss_6/neg_items_grad/Shape5gradients_3/loss_6/neg_items_grad/strided_slice/stack7gradients_3/loss_6/neg_items_grad/strided_slice/stack_17gradients_3/loss_6/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_3/loss_6/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_3/loss_6/neg_items_grad/concatConcatV2,gradients_3/loss_6/neg_items_grad/ExpandDims/gradients_3/loss_6/neg_items_grad/strided_slice-gradients_3/loss_6/neg_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_3/loss_6/neg_items_grad/ReshapeReshapegradients_3/AddN_4(gradients_3/loss_6/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_3/loss_6/neg_items_grad/Reshape_1Reshape placeholders_3/sampled_neg_items,gradients_3/loss_6/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
[
gradients_3/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_3/concat_2ConcatV2)gradients_3/loss_6/pos_items_grad/Reshape)gradients_3/loss_6/neg_items_grad/Reshapegradients_3/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_3/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_3/concat_3ConcatV2+gradients_3/loss_6/pos_items_grad/Reshape_1+gradients_3/loss_6/neg_items_grad/Reshape_1gradients_3/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
d
GradientDescent_3/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_3/update_variables_3/user_factors/mulMul%gradients_3/loss_6/users_grad/ReshapeGradientDescent_3/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_3/user_factors
Њ
<GradientDescent_3/update_variables_3/user_factors/ScatterSub
ScatterSubvariables_3/user_factors'gradients_3/loss_6/users_grad/Reshape_15GradientDescent_3/update_variables_3/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_3/user_factors
џ
5GradientDescent_3/update_variables_3/item_factors/mulMulgradients_3/concat_2GradientDescent_3/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_3/item_factors
Ђ
<GradientDescent_3/update_variables_3/item_factors/ScatterSub
ScatterSubvariables_3/item_factorsgradients_3/concat_35GradientDescent_3/update_variables_3/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_3/item_factors
∆
2GradientDescent_3/update_variables_3/item_bias/mulMulgradients_3/concatGradientDescent_3/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_3/item_bias
Ы
9GradientDescent_3/update_variables_3/item_bias/ScatterSub
ScatterSubvariables_3/item_biasgradients_3/concat_12GradientDescent_3/update_variables_3/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_3/item_bias
”
GradientDescent_3NoOp=^GradientDescent_3/update_variables_3/user_factors/ScatterSub=^GradientDescent_3/update_variables_3/item_factors/ScatterSub:^GradientDescent_3/update_variables_3/item_bias/ScatterSub
R
loss_7/tagsConst*
valueB Bloss_7*
_output_shapes
: *
dtype0
S
loss_7ScalarSummaryloss_7/tagsloss_6/sub_2*
_output_shapes
: *
T0
e
Merge_3/MergeSummaryMergeSummaryloss_1loss_3loss_5loss_7*
_output_shapes
: *
N
Ф
init_3NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign ^variables_2/user_factors/Assign ^variables_2/item_factors/Assign^variables_2/item_bias/Assign ^variables_3/user_factors/Assign ^variables_3/item_factors/Assign^variables_3/item_bias/Assign
j
placeholders_4/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_4/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_4/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_4/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_4/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_4/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_4/truncated_normal/TruncatedNormalTruncatedNormal"variables_4/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_4/truncated_normal/mulMul,variables_4/truncated_normal/TruncatedNormal#variables_4/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_4/truncated_normalAdd variables_4/truncated_normal/mul!variables_4/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_4/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_4/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_4/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_4/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_4/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_4/truncated_normal_1/mulMul.variables_4/truncated_normal_1/TruncatedNormal%variables_4/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_4/truncated_normal_1Add"variables_4/truncated_normal_1/mul#variables_4/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_4/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_4/user_factors/AssignAssignvariables_4/user_factorsvariables_4/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_4/user_factors
Ъ
variables_4/user_factors/readIdentityvariables_4/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_4/user_factors
О
variables_4/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_4/item_factors/AssignAssignvariables_4/item_factorsvariables_4/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_4/item_factors
Ъ
variables_4/item_factors/readIdentityvariables_4/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_4/item_factors
`
variables_4/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_4/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_4/item_bias/AssignAssignvariables_4/item_biasvariables_4/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_4/item_bias
Н
variables_4/item_bias/readIdentityvariables_4/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_4/item_bias
≥
loss_8/usersGathervariables_4/user_factors/readplaceholders_4/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_8/pos_itemsGathervariables_4/item_factors/read placeholders_4/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_8/neg_itemsGathervariables_4/item_factors/read placeholders_4/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_8/pos_item_biasGathervariables_4/item_bias/read placeholders_4/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_8/neg_item_biasGathervariables_4/item_bias/read placeholders_4/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_8/subSubloss_8/pos_itemsloss_8/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_8/mulMulloss_8/users
loss_8/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_8/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_8/SumSum
loss_8/mulloss_8/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_8/sub_1Subloss_8/pos_item_biasloss_8/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_8/addAddloss_8/sub_1
loss_8/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_8/SigmoidSigmoid
loss_8/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_8/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_8/clip_by_value/MinimumMinimumloss_8/Sigmoidloss_8/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_8/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_8/clip_by_valueMaximumloss_8/clip_by_value/Minimumloss_8/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_8/LogLogloss_8/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_8/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_8/Sum_1Sum
loss_8/Logloss_8/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_8/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_8/powPowloss_8/usersloss_8/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_8/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_8/Sum_2Sum
loss_8/powloss_8/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_8/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_8/mul_1Mulloss_8/mul_1/xloss_8/Sum_2*
_output_shapes
: *
T0
S
loss_8/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_1Powloss_8/pos_itemsloss_8/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_8/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_8/Sum_3Sumloss_8/pow_1loss_8/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_8/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_8/mul_2Mulloss_8/mul_2/xloss_8/Sum_3*
_output_shapes
: *
T0
S
loss_8/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_2Powloss_8/pos_item_biasloss_8/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_8/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_8/Sum_4Sumloss_8/pow_2loss_8/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_8/add_1Addloss_8/mul_2loss_8/Sum_4*
_output_shapes
: *
T0
S
loss_8/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_3Powloss_8/neg_itemsloss_8/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_8/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_8/Sum_5Sumloss_8/pow_3loss_8/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_8/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_8/mul_3Mulloss_8/mul_3/xloss_8/Sum_5*
_output_shapes
: *
T0
S
loss_8/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_4Powloss_8/neg_item_biasloss_8/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_8/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_8/Sum_6Sumloss_8/pow_4loss_8/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_8/add_2Addloss_8/mul_3loss_8/Sum_6*
_output_shapes
: *
T0
P
loss_8/add_3Addloss_8/mul_1loss_8/add_1*
_output_shapes
: *
T0
P
loss_8/add_4Addloss_8/add_3loss_8/add_2*
_output_shapes
: *
T0
P
loss_8/sub_2Subloss_8/add_4loss_8/Sum_1*
_output_shapes
: *
T0
T
gradients_4/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_4/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_4/FillFillgradients_4/Shapegradients_4/Const*
_output_shapes
: *
T0
f
#gradients_4/loss_8/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/sub_2_grad/Shape%gradients_4/loss_8/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_4/loss_8/sub_2_grad/SumSumgradients_4/Fill3gradients_4/loss_8/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/sub_2_grad/ReshapeReshape!gradients_4/loss_8/sub_2_grad/Sum#gradients_4/loss_8/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
≥
#gradients_4/loss_8/sub_2_grad/Sum_1Sumgradients_4/Fill5gradients_4/loss_8/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_4/loss_8/sub_2_grad/NegNeg#gradients_4/loss_8/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_4/loss_8/sub_2_grad/Reshape_1Reshape!gradients_4/loss_8/sub_2_grad/Neg%gradients_4/loss_8/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/sub_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/sub_2_grad/Reshape(^gradients_4/loss_8/sub_2_grad/Reshape_1
х
6gradients_4/loss_8/sub_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/sub_2_grad/Reshape/^gradients_4/loss_8/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/sub_2_grad/Reshape
ы
8gradients_4/loss_8/sub_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/sub_2_grad/Reshape_1/^gradients_4/loss_8/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/sub_2_grad/Reshape_1
f
#gradients_4/loss_8/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_4_grad/Shape%gradients_4/loss_8/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_4/loss_8/add_4_grad/SumSum6gradients_4/loss_8/sub_2_grad/tuple/control_dependency3gradients_4/loss_8/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_4_grad/ReshapeReshape!gradients_4/loss_8/add_4_grad/Sum#gradients_4/loss_8/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_4/loss_8/add_4_grad/Sum_1Sum6gradients_4/loss_8/sub_2_grad/tuple/control_dependency5gradients_4/loss_8/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_4_grad/Reshape_1Reshape#gradients_4/loss_8/add_4_grad/Sum_1%gradients_4/loss_8/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/add_4_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_4_grad/Reshape(^gradients_4/loss_8/add_4_grad/Reshape_1
х
6gradients_4/loss_8/add_4_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_4_grad/Reshape/^gradients_4/loss_8/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_4_grad/Reshape
ы
8gradients_4/loss_8/add_4_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_4_grad/Reshape_1/^gradients_4/loss_8/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_4_grad/Reshape_1
u
+gradients_4/loss_8/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_4/loss_8/Sum_1_grad/ReshapeReshape8gradients_4/loss_8/sub_2_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_1_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
m
#gradients_4/loss_8/Sum_1_grad/ShapeShape
loss_8/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_4/loss_8/Sum_1_grad/TileTile%gradients_4/loss_8/Sum_1_grad/Reshape#gradients_4/loss_8/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_4/loss_8/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_3_grad/Shape%gradients_4/loss_8/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_4/loss_8/add_3_grad/SumSum6gradients_4/loss_8/add_4_grad/tuple/control_dependency3gradients_4/loss_8/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_3_grad/ReshapeReshape!gradients_4/loss_8/add_3_grad/Sum#gradients_4/loss_8/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
ў
#gradients_4/loss_8/add_3_grad/Sum_1Sum6gradients_4/loss_8/add_4_grad/tuple/control_dependency5gradients_4/loss_8/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_3_grad/Reshape_1Reshape#gradients_4/loss_8/add_3_grad/Sum_1%gradients_4/loss_8/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/add_3_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_3_grad/Reshape(^gradients_4/loss_8/add_3_grad/Reshape_1
х
6gradients_4/loss_8/add_3_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_3_grad/Reshape/^gradients_4/loss_8/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_3_grad/Reshape
ы
8gradients_4/loss_8/add_3_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_3_grad/Reshape_1/^gradients_4/loss_8/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_3_grad/Reshape_1
f
#gradients_4/loss_8/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_2_grad/Shape%gradients_4/loss_8/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_4/loss_8/add_2_grad/SumSum8gradients_4/loss_8/add_4_grad/tuple/control_dependency_13gradients_4/loss_8/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_2_grad/ReshapeReshape!gradients_4/loss_8/add_2_grad/Sum#gradients_4/loss_8/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_4/loss_8/add_2_grad/Sum_1Sum8gradients_4/loss_8/add_4_grad/tuple/control_dependency_15gradients_4/loss_8/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_2_grad/Reshape_1Reshape#gradients_4/loss_8/add_2_grad/Sum_1%gradients_4/loss_8/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/add_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_2_grad/Reshape(^gradients_4/loss_8/add_2_grad/Reshape_1
х
6gradients_4/loss_8/add_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_2_grad/Reshape/^gradients_4/loss_8/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_2_grad/Reshape
ы
8gradients_4/loss_8/add_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_2_grad/Reshape_1/^gradients_4/loss_8/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_2_grad/Reshape_1
Э
&gradients_4/loss_8/Log_grad/Reciprocal
Reciprocalloss_8/clip_by_value#^gradients_4/loss_8/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_4/loss_8/Log_grad/mulMul"gradients_4/loss_8/Sum_1_grad/Tile&gradients_4/loss_8/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_4/loss_8/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/mul_1_grad/Shape%gradients_4/loss_8/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_4/loss_8/mul_1_grad/mulMul6gradients_4/loss_8/add_3_grad/tuple/control_dependencyloss_8/Sum_2*
_output_shapes
: *
T0
ј
!gradients_4/loss_8/mul_1_grad/SumSum!gradients_4/loss_8/mul_1_grad/mul3gradients_4/loss_8/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/mul_1_grad/ReshapeReshape!gradients_4/loss_8/mul_1_grad/Sum#gradients_4/loss_8/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_4/loss_8/mul_1_grad/mul_1Mulloss_8/mul_1/x6gradients_4/loss_8/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_4/loss_8/mul_1_grad/Sum_1Sum#gradients_4/loss_8/mul_1_grad/mul_15gradients_4/loss_8/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/mul_1_grad/Reshape_1Reshape#gradients_4/loss_8/mul_1_grad/Sum_1%gradients_4/loss_8/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/mul_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/mul_1_grad/Reshape(^gradients_4/loss_8/mul_1_grad/Reshape_1
х
6gradients_4/loss_8/mul_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/mul_1_grad/Reshape/^gradients_4/loss_8/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_1_grad/Reshape
ы
8gradients_4/loss_8/mul_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/mul_1_grad/Reshape_1/^gradients_4/loss_8/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/mul_1_grad/Reshape_1
f
#gradients_4/loss_8/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_1_grad/Shape%gradients_4/loss_8/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_4/loss_8/add_1_grad/SumSum8gradients_4/loss_8/add_3_grad/tuple/control_dependency_13gradients_4/loss_8/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_1_grad/ReshapeReshape!gradients_4/loss_8/add_1_grad/Sum#gradients_4/loss_8/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
џ
#gradients_4/loss_8/add_1_grad/Sum_1Sum8gradients_4/loss_8/add_3_grad/tuple/control_dependency_15gradients_4/loss_8/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_1_grad/Reshape_1Reshape#gradients_4/loss_8/add_1_grad/Sum_1%gradients_4/loss_8/add_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/add_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_1_grad/Reshape(^gradients_4/loss_8/add_1_grad/Reshape_1
х
6gradients_4/loss_8/add_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_1_grad/Reshape/^gradients_4/loss_8/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_1_grad/Reshape
ы
8gradients_4/loss_8/add_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_1_grad/Reshape_1/^gradients_4/loss_8/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_1_grad/Reshape_1
f
#gradients_4/loss_8/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/mul_3_grad/Shape%gradients_4/loss_8/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_4/loss_8/mul_3_grad/mulMul6gradients_4/loss_8/add_2_grad/tuple/control_dependencyloss_8/Sum_5*
_output_shapes
: *
T0
ј
!gradients_4/loss_8/mul_3_grad/SumSum!gradients_4/loss_8/mul_3_grad/mul3gradients_4/loss_8/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/mul_3_grad/ReshapeReshape!gradients_4/loss_8/mul_3_grad/Sum#gradients_4/loss_8/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_4/loss_8/mul_3_grad/mul_1Mulloss_8/mul_3/x6gradients_4/loss_8/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_4/loss_8/mul_3_grad/Sum_1Sum#gradients_4/loss_8/mul_3_grad/mul_15gradients_4/loss_8/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/mul_3_grad/Reshape_1Reshape#gradients_4/loss_8/mul_3_grad/Sum_1%gradients_4/loss_8/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/mul_3_grad/tuple/group_depsNoOp&^gradients_4/loss_8/mul_3_grad/Reshape(^gradients_4/loss_8/mul_3_grad/Reshape_1
х
6gradients_4/loss_8/mul_3_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/mul_3_grad/Reshape/^gradients_4/loss_8/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_3_grad/Reshape
ы
8gradients_4/loss_8/mul_3_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/mul_3_grad/Reshape_1/^gradients_4/loss_8/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/mul_3_grad/Reshape_1
u
+gradients_4/loss_8/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_4/loss_8/Sum_6_grad/ReshapeReshape8gradients_4/loss_8/add_2_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_6_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_4/loss_8/Sum_6_grad/ShapeShapeloss_8/pow_4*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_4/loss_8/Sum_6_grad/TileTile%gradients_4/loss_8/Sum_6_grad/Reshape#gradients_4/loss_8/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_4/loss_8/clip_by_value_grad/ShapeShapeloss_8/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_4/loss_8/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_4/loss_8/clip_by_value_grad/Shape_2Shapegradients_4/loss_8/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_4/loss_8/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_4/loss_8/clip_by_value_grad/zerosFill-gradients_4/loss_8/clip_by_value_grad/Shape_21gradients_4/loss_8/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_4/loss_8/clip_by_value_grad/GreaterEqualGreaterEqualloss_8/clip_by_value/Minimumloss_8/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_4/loss_8/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_4/loss_8/clip_by_value_grad/Shape-gradients_4/loss_8/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_4/loss_8/clip_by_value_grad/SelectSelect2gradients_4/loss_8/clip_by_value_grad/GreaterEqualgradients_4/loss_8/Log_grad/mul+gradients_4/loss_8/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_4/loss_8/clip_by_value_grad/LogicalNot
LogicalNot2gradients_4/loss_8/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_4/loss_8/clip_by_value_grad/Select_1Select0gradients_4/loss_8/clip_by_value_grad/LogicalNotgradients_4/loss_8/Log_grad/mul+gradients_4/loss_8/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_4/loss_8/clip_by_value_grad/SumSum,gradients_4/loss_8/clip_by_value_grad/Select;gradients_4/loss_8/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_4/loss_8/clip_by_value_grad/ReshapeReshape)gradients_4/loss_8/clip_by_value_grad/Sum+gradients_4/loss_8/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
б
+gradients_4/loss_8/clip_by_value_grad/Sum_1Sum.gradients_4/loss_8/clip_by_value_grad/Select_1=gradients_4/loss_8/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_4/loss_8/clip_by_value_grad/Reshape_1Reshape+gradients_4/loss_8/clip_by_value_grad/Sum_1-gradients_4/loss_8/clip_by_value_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
†
6gradients_4/loss_8/clip_by_value_grad/tuple/group_depsNoOp.^gradients_4/loss_8/clip_by_value_grad/Reshape0^gradients_4/loss_8/clip_by_value_grad/Reshape_1
Ґ
>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_4/loss_8/clip_by_value_grad/Reshape7^gradients_4/loss_8/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_4/loss_8/clip_by_value_grad/Reshape
Ы
@gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_4/loss_8/clip_by_value_grad/Reshape_17^gradients_4/loss_8/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_4/loss_8/clip_by_value_grad/Reshape_1
|
+gradients_4/loss_8/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_4/loss_8/Sum_2_grad/ReshapeReshape8gradients_4/loss_8/mul_1_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_2_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
m
#gradients_4/loss_8/Sum_2_grad/ShapeShape
loss_8/pow*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_4/loss_8/Sum_2_grad/TileTile%gradients_4/loss_8/Sum_2_grad/Reshape#gradients_4/loss_8/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_4/loss_8/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/mul_2_grad/Shape%gradients_4/loss_8/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_4/loss_8/mul_2_grad/mulMul6gradients_4/loss_8/add_1_grad/tuple/control_dependencyloss_8/Sum_3*
_output_shapes
: *
T0
ј
!gradients_4/loss_8/mul_2_grad/SumSum!gradients_4/loss_8/mul_2_grad/mul3gradients_4/loss_8/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/mul_2_grad/ReshapeReshape!gradients_4/loss_8/mul_2_grad/Sum#gradients_4/loss_8/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
У
#gradients_4/loss_8/mul_2_grad/mul_1Mulloss_8/mul_2/x6gradients_4/loss_8/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_4/loss_8/mul_2_grad/Sum_1Sum#gradients_4/loss_8/mul_2_grad/mul_15gradients_4/loss_8/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/mul_2_grad/Reshape_1Reshape#gradients_4/loss_8/mul_2_grad/Sum_1%gradients_4/loss_8/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/mul_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/mul_2_grad/Reshape(^gradients_4/loss_8/mul_2_grad/Reshape_1
х
6gradients_4/loss_8/mul_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/mul_2_grad/Reshape/^gradients_4/loss_8/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_2_grad/Reshape
ы
8gradients_4/loss_8/mul_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/mul_2_grad/Reshape_1/^gradients_4/loss_8/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/mul_2_grad/Reshape_1
u
+gradients_4/loss_8/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_4/loss_8/Sum_4_grad/ReshapeReshape8gradients_4/loss_8/add_1_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_4_grad/Reshape/shape*
_output_shapes
:*
T0*
Tshape0
o
#gradients_4/loss_8/Sum_4_grad/ShapeShapeloss_8/pow_2*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_4/loss_8/Sum_4_grad/TileTile%gradients_4/loss_8/Sum_4_grad/Reshape#gradients_4/loss_8/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_4/loss_8/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_4/loss_8/Sum_5_grad/ReshapeReshape8gradients_4/loss_8/mul_3_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_5_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_4/loss_8/Sum_5_grad/ShapeShapeloss_8/pow_3*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_4/loss_8/Sum_5_grad/TileTile%gradients_4/loss_8/Sum_5_grad/Reshape#gradients_4/loss_8/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_4/loss_8/pow_4_grad/ShapeShapeloss_8/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_4_grad/Shape%gradients_4/loss_8/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_4/loss_8/pow_4_grad/mulMul"gradients_4/loss_8/Sum_6_grad/Tileloss_8/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_4/loss_8/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_4_grad/subSubloss_8/pow_4/y#gradients_4/loss_8/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_4_grad/PowPowloss_8/neg_item_bias!gradients_4/loss_8/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_4/loss_8/pow_4_grad/mul_1Mul!gradients_4/loss_8/pow_4_grad/mul!gradients_4/loss_8/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_4/loss_8/pow_4_grad/SumSum#gradients_4/loss_8/pow_4_grad/mul_13gradients_4/loss_8/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/pow_4_grad/ReshapeReshape!gradients_4/loss_8/pow_4_grad/Sum#gradients_4/loss_8/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_4/loss_8/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_4_grad/GreaterGreaterloss_8/neg_item_bias'gradients_4/loss_8/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_4/loss_8/pow_4_grad/LogLogloss_8/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_4/loss_8/pow_4_grad/zeros_like	ZerosLikeloss_8/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_4/loss_8/pow_4_grad/SelectSelect%gradients_4/loss_8/pow_4_grad/Greater!gradients_4/loss_8/pow_4_grad/Log(gradients_4/loss_8/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_4/loss_8/pow_4_grad/mul_2Mul"gradients_4/loss_8/Sum_6_grad/Tileloss_8/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_4/loss_8/pow_4_grad/mul_3Mul#gradients_4/loss_8/pow_4_grad/mul_2$gradients_4/loss_8/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_4/loss_8/pow_4_grad/Sum_1Sum#gradients_4/loss_8/pow_4_grad/mul_35gradients_4/loss_8/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_4_grad/Reshape_1Reshape#gradients_4/loss_8/pow_4_grad/Sum_1%gradients_4/loss_8/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/pow_4_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_4_grad/Reshape(^gradients_4/loss_8/pow_4_grad/Reshape_1
В
6gradients_4/loss_8/pow_4_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_4_grad/Reshape/^gradients_4/loss_8/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_4_grad/Reshape
ы
8gradients_4/loss_8/pow_4_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_4_grad/Reshape_1/^gradients_4/loss_8/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_4_grad/Reshape_1
Б
3gradients_4/loss_8/clip_by_value/Minimum_grad/ShapeShapeloss_8/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_2Shape>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_4/loss_8/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_4/loss_8/clip_by_value/Minimum_grad/zerosFill5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_29gradients_4/loss_8/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_4/loss_8/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_8/Sigmoidloss_8/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_4/loss_8/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_4/loss_8/clip_by_value/Minimum_grad/Shape5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_4/loss_8/clip_by_value/Minimum_grad/SelectSelect7gradients_4/loss_8/clip_by_value/Minimum_grad/LessEqual>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency3gradients_4/loss_8/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_4/loss_8/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_4/loss_8/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_4/loss_8/clip_by_value/Minimum_grad/Select_1Select8gradients_4/loss_8/clip_by_value/Minimum_grad/LogicalNot>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency3gradients_4/loss_8/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_4/loss_8/clip_by_value/Minimum_grad/SumSum4gradients_4/loss_8/clip_by_value/Minimum_grad/SelectCgradients_4/loss_8/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_4/loss_8/clip_by_value/Minimum_grad/ReshapeReshape1gradients_4/loss_8/clip_by_value/Minimum_grad/Sum3gradients_4/loss_8/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
щ
3gradients_4/loss_8/clip_by_value/Minimum_grad/Sum_1Sum6gradients_4/loss_8/clip_by_value/Minimum_grad/Select_1Egradients_4/loss_8/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_4/loss_8/clip_by_value/Minimum_grad/Sum_15gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
Є
>gradients_4/loss_8/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape8^gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_4/loss_8/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape?^gradients_4/loss_8/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_4/loss_8/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1?^gradients_4/loss_8/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_4/loss_8/pow_grad/ShapeShapeloss_8/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_4/loss_8/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_4/loss_8/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/pow_grad/Shape#gradients_4/loss_8/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_4/loss_8/pow_grad/mulMul"gradients_4/loss_8/Sum_2_grad/Tileloss_8/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_4/loss_8/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_4/loss_8/pow_grad/subSubloss_8/pow/y!gradients_4/loss_8/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_4/loss_8/pow_grad/PowPowloss_8/usersgradients_4/loss_8/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_4/loss_8/pow_grad/mul_1Mulgradients_4/loss_8/pow_grad/mulgradients_4/loss_8/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_4/loss_8/pow_grad/SumSum!gradients_4/loss_8/pow_grad/mul_11gradients_4/loss_8/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_4/loss_8/pow_grad/ReshapeReshapegradients_4/loss_8/pow_grad/Sum!gradients_4/loss_8/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
j
%gradients_4/loss_8/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_4/loss_8/pow_grad/GreaterGreaterloss_8/users%gradients_4/loss_8/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_4/loss_8/pow_grad/LogLogloss_8/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_4/loss_8/pow_grad/zeros_like	ZerosLikeloss_8/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_4/loss_8/pow_grad/SelectSelect#gradients_4/loss_8/pow_grad/Greatergradients_4/loss_8/pow_grad/Log&gradients_4/loss_8/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_4/loss_8/pow_grad/mul_2Mul"gradients_4/loss_8/Sum_2_grad/Tile
loss_8/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_4/loss_8/pow_grad/mul_3Mul!gradients_4/loss_8/pow_grad/mul_2"gradients_4/loss_8/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_4/loss_8/pow_grad/Sum_1Sum!gradients_4/loss_8/pow_grad/mul_33gradients_4/loss_8/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/pow_grad/Reshape_1Reshape!gradients_4/loss_8/pow_grad/Sum_1#gradients_4/loss_8/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
В
,gradients_4/loss_8/pow_grad/tuple/group_depsNoOp$^gradients_4/loss_8/pow_grad/Reshape&^gradients_4/loss_8/pow_grad/Reshape_1
ю
4gradients_4/loss_8/pow_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/pow_grad/Reshape-^gradients_4/loss_8/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_4/loss_8/pow_grad/Reshape
у
6gradients_4/loss_8/pow_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/pow_grad/Reshape_1-^gradients_4/loss_8/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_grad/Reshape_1
|
+gradients_4/loss_8/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_4/loss_8/Sum_3_grad/ReshapeReshape8gradients_4/loss_8/mul_2_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_3_grad/Reshape/shape*
_output_shapes

:*
T0*
Tshape0
o
#gradients_4/loss_8/Sum_3_grad/ShapeShapeloss_8/pow_1*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_4/loss_8/Sum_3_grad/TileTile%gradients_4/loss_8/Sum_3_grad/Reshape#gradients_4/loss_8/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_4/loss_8/pow_2_grad/ShapeShapeloss_8/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_2_grad/Shape%gradients_4/loss_8/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_4/loss_8/pow_2_grad/mulMul"gradients_4/loss_8/Sum_4_grad/Tileloss_8/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_4/loss_8/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_2_grad/subSubloss_8/pow_2/y#gradients_4/loss_8/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_2_grad/PowPowloss_8/pos_item_bias!gradients_4/loss_8/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_4/loss_8/pow_2_grad/mul_1Mul!gradients_4/loss_8/pow_2_grad/mul!gradients_4/loss_8/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_4/loss_8/pow_2_grad/SumSum#gradients_4/loss_8/pow_2_grad/mul_13gradients_4/loss_8/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/pow_2_grad/ReshapeReshape!gradients_4/loss_8/pow_2_grad/Sum#gradients_4/loss_8/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
l
'gradients_4/loss_8/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_2_grad/GreaterGreaterloss_8/pos_item_bias'gradients_4/loss_8/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_4/loss_8/pow_2_grad/LogLogloss_8/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_4/loss_8/pow_2_grad/zeros_like	ZerosLikeloss_8/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_4/loss_8/pow_2_grad/SelectSelect%gradients_4/loss_8/pow_2_grad/Greater!gradients_4/loss_8/pow_2_grad/Log(gradients_4/loss_8/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_4/loss_8/pow_2_grad/mul_2Mul"gradients_4/loss_8/Sum_4_grad/Tileloss_8/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_4/loss_8/pow_2_grad/mul_3Mul#gradients_4/loss_8/pow_2_grad/mul_2$gradients_4/loss_8/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_4/loss_8/pow_2_grad/Sum_1Sum#gradients_4/loss_8/pow_2_grad/mul_35gradients_4/loss_8/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_2_grad/Reshape_1Reshape#gradients_4/loss_8/pow_2_grad/Sum_1%gradients_4/loss_8/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/pow_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_2_grad/Reshape(^gradients_4/loss_8/pow_2_grad/Reshape_1
В
6gradients_4/loss_8/pow_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_2_grad/Reshape/^gradients_4/loss_8/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_2_grad/Reshape
ы
8gradients_4/loss_8/pow_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_2_grad/Reshape_1/^gradients_4/loss_8/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_2_grad/Reshape_1
s
#gradients_4/loss_8/pow_3_grad/ShapeShapeloss_8/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_3_grad/Shape%gradients_4/loss_8/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_4/loss_8/pow_3_grad/mulMul"gradients_4/loss_8/Sum_5_grad/Tileloss_8/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_4/loss_8/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_3_grad/subSubloss_8/pow_3/y#gradients_4/loss_8/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_3_grad/PowPowloss_8/neg_items!gradients_4/loss_8/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_4/loss_8/pow_3_grad/mul_1Mul!gradients_4/loss_8/pow_3_grad/mul!gradients_4/loss_8/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_4/loss_8/pow_3_grad/SumSum#gradients_4/loss_8/pow_3_grad/mul_13gradients_4/loss_8/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_4/loss_8/pow_3_grad/ReshapeReshape!gradients_4/loss_8/pow_3_grad/Sum#gradients_4/loss_8/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_4/loss_8/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_3_grad/GreaterGreaterloss_8/neg_items'gradients_4/loss_8/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_4/loss_8/pow_3_grad/LogLogloss_8/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_4/loss_8/pow_3_grad/zeros_like	ZerosLikeloss_8/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_4/loss_8/pow_3_grad/SelectSelect%gradients_4/loss_8/pow_3_grad/Greater!gradients_4/loss_8/pow_3_grad/Log(gradients_4/loss_8/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_4/loss_8/pow_3_grad/mul_2Mul"gradients_4/loss_8/Sum_5_grad/Tileloss_8/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_4/loss_8/pow_3_grad/mul_3Mul#gradients_4/loss_8/pow_3_grad/mul_2$gradients_4/loss_8/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_4/loss_8/pow_3_grad/Sum_1Sum#gradients_4/loss_8/pow_3_grad/mul_35gradients_4/loss_8/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_3_grad/Reshape_1Reshape#gradients_4/loss_8/pow_3_grad/Sum_1%gradients_4/loss_8/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/pow_3_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_3_grad/Reshape(^gradients_4/loss_8/pow_3_grad/Reshape_1
Ж
6gradients_4/loss_8/pow_3_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_3_grad/Reshape/^gradients_4/loss_8/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_3_grad/Reshape
ы
8gradients_4/loss_8/pow_3_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_3_grad/Reshape_1/^gradients_4/loss_8/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_3_grad/Reshape_1
ј
+gradients_4/loss_8/Sigmoid_grad/SigmoidGradSigmoidGradloss_8/SigmoidFgradients_4/loss_8/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_4/loss_8/pow_1_grad/ShapeShapeloss_8/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_1_grad/Shape%gradients_4/loss_8/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_4/loss_8/pow_1_grad/mulMul"gradients_4/loss_8/Sum_3_grad/Tileloss_8/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_4/loss_8/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_1_grad/subSubloss_8/pow_1/y#gradients_4/loss_8/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_1_grad/PowPowloss_8/pos_items!gradients_4/loss_8/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_4/loss_8/pow_1_grad/mul_1Mul!gradients_4/loss_8/pow_1_grad/mul!gradients_4/loss_8/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_4/loss_8/pow_1_grad/SumSum#gradients_4/loss_8/pow_1_grad/mul_13gradients_4/loss_8/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_4/loss_8/pow_1_grad/ReshapeReshape!gradients_4/loss_8/pow_1_grad/Sum#gradients_4/loss_8/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
l
'gradients_4/loss_8/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_1_grad/GreaterGreaterloss_8/pos_items'gradients_4/loss_8/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_4/loss_8/pow_1_grad/LogLogloss_8/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_4/loss_8/pow_1_grad/zeros_like	ZerosLikeloss_8/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_4/loss_8/pow_1_grad/SelectSelect%gradients_4/loss_8/pow_1_grad/Greater!gradients_4/loss_8/pow_1_grad/Log(gradients_4/loss_8/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_4/loss_8/pow_1_grad/mul_2Mul"gradients_4/loss_8/Sum_3_grad/Tileloss_8/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_4/loss_8/pow_1_grad/mul_3Mul#gradients_4/loss_8/pow_1_grad/mul_2$gradients_4/loss_8/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_4/loss_8/pow_1_grad/Sum_1Sum#gradients_4/loss_8/pow_1_grad/mul_35gradients_4/loss_8/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_1_grad/Reshape_1Reshape#gradients_4/loss_8/pow_1_grad/Sum_1%gradients_4/loss_8/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
И
.gradients_4/loss_8/pow_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_1_grad/Reshape(^gradients_4/loss_8/pow_1_grad/Reshape_1
Ж
6gradients_4/loss_8/pow_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_1_grad/Reshape/^gradients_4/loss_8/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_1_grad/Reshape
ы
8gradients_4/loss_8/pow_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_1_grad/Reshape_1/^gradients_4/loss_8/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_1_grad/Reshape_1
m
!gradients_4/loss_8/add_grad/ShapeShapeloss_8/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_4/loss_8/add_grad/Shape_1Shape
loss_8/Sum*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_4/loss_8/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/add_grad/Shape#gradients_4/loss_8/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_4/loss_8/add_grad/SumSum+gradients_4/loss_8/Sigmoid_grad/SigmoidGrad1gradients_4/loss_8/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_4/loss_8/add_grad/ReshapeReshapegradients_4/loss_8/add_grad/Sum!gradients_4/loss_8/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
!gradients_4/loss_8/add_grad/Sum_1Sum+gradients_4/loss_8/Sigmoid_grad/SigmoidGrad3gradients_4/loss_8/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/add_grad/Reshape_1Reshape!gradients_4/loss_8/add_grad/Sum_1#gradients_4/loss_8/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
В
,gradients_4/loss_8/add_grad/tuple/group_depsNoOp$^gradients_4/loss_8/add_grad/Reshape&^gradients_4/loss_8/add_grad/Reshape_1
ъ
4gradients_4/loss_8/add_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/add_grad/Reshape-^gradients_4/loss_8/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_4/loss_8/add_grad/Reshape
А
6gradients_4/loss_8/add_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/add_grad/Reshape_1-^gradients_4/loss_8/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/add_grad/Reshape_1
w
#gradients_4/loss_8/sub_1_grad/ShapeShapeloss_8/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_4/loss_8/sub_1_grad/Shape_1Shapeloss_8/neg_item_bias*
_output_shapes
:*
T0*
out_type0
’
3gradients_4/loss_8/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/sub_1_grad/Shape%gradients_4/loss_8/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_4/loss_8/sub_1_grad/SumSum4gradients_4/loss_8/add_grad/tuple/control_dependency3gradients_4/loss_8/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/sub_1_grad/ReshapeReshape!gradients_4/loss_8/sub_1_grad/Sum#gradients_4/loss_8/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
„
#gradients_4/loss_8/sub_1_grad/Sum_1Sum4gradients_4/loss_8/add_grad/tuple/control_dependency5gradients_4/loss_8/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_4/loss_8/sub_1_grad/NegNeg#gradients_4/loss_8/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_4/loss_8/sub_1_grad/Reshape_1Reshape!gradients_4/loss_8/sub_1_grad/Neg%gradients_4/loss_8/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
И
.gradients_4/loss_8/sub_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/sub_1_grad/Reshape(^gradients_4/loss_8/sub_1_grad/Reshape_1
В
6gradients_4/loss_8/sub_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/sub_1_grad/Reshape/^gradients_4/loss_8/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/sub_1_grad/Reshape
И
8gradients_4/loss_8/sub_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/sub_1_grad/Reshape_1/^gradients_4/loss_8/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*:
_class0
.,loc:@gradients_4/loss_8/sub_1_grad/Reshape_1
k
!gradients_4/loss_8/Sum_grad/ShapeShape
loss_8/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_4/loss_8/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_4/loss_8/Sum_grad/addAddloss_8/Sum/reduction_indices gradients_4/loss_8/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_4/loss_8/Sum_grad/modFloorModgradients_4/loss_8/Sum_grad/add gradients_4/loss_8/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_4/loss_8/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_4/loss_8/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_4/loss_8/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_4/loss_8/Sum_grad/rangeRange'gradients_4/loss_8/Sum_grad/range/start gradients_4/loss_8/Sum_grad/Size'gradients_4/loss_8/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_4/loss_8/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_4/loss_8/Sum_grad/FillFill#gradients_4/loss_8/Sum_grad/Shape_1&gradients_4/loss_8/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_4/loss_8/Sum_grad/DynamicStitchDynamicStitch!gradients_4/loss_8/Sum_grad/rangegradients_4/loss_8/Sum_grad/mod!gradients_4/loss_8/Sum_grad/Shape gradients_4/loss_8/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
N*
T0
g
%gradients_4/loss_8/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_4/loss_8/Sum_grad/MaximumMaximum)gradients_4/loss_8/Sum_grad/DynamicStitch%gradients_4/loss_8/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_4/loss_8/Sum_grad/floordivFloorDiv!gradients_4/loss_8/Sum_grad/Shape#gradients_4/loss_8/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_4/loss_8/Sum_grad/ReshapeReshape6gradients_4/loss_8/add_grad/tuple/control_dependency_1)gradients_4/loss_8/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
Ј
 gradients_4/loss_8/Sum_grad/TileTile#gradients_4/loss_8/Sum_grad/Reshape$gradients_4/loss_8/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_4/AddNAddN6gradients_4/loss_8/pow_2_grad/tuple/control_dependency6gradients_4/loss_8/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_2_grad/Reshape
†
+gradients_4/loss_8/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_4/item_bias
Е
*gradients_4/loss_8/pos_item_bias_grad/SizeSize placeholders_4/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_4/loss_8/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_4/loss_8/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_4/loss_8/pos_item_bias_grad/Size4gradients_4/loss_8/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_4/loss_8/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_4/loss_8/pos_item_bias_grad/strided_sliceStridedSlice+gradients_4/loss_8/pos_item_bias_grad/Shape9gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_1;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_4/loss_8/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_4/loss_8/pos_item_bias_grad/concatConcatV20gradients_4/loss_8/pos_item_bias_grad/ExpandDims3gradients_4/loss_8/pos_item_bias_grad/strided_slice1gradients_4/loss_8/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
і
-gradients_4/loss_8/pos_item_bias_grad/ReshapeReshapegradients_4/AddN,gradients_4/loss_8/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_4/loss_8/pos_item_bias_grad/Reshape_1Reshape placeholders_4/sampled_pos_items0gradients_4/loss_8/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
э
gradients_4/AddN_1AddN6gradients_4/loss_8/pow_4_grad/tuple/control_dependency8gradients_4/loss_8/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
N*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_4_grad/Reshape
†
+gradients_4/loss_8/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_4/item_bias
Е
*gradients_4/loss_8/neg_item_bias_grad/SizeSize placeholders_4/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_4/loss_8/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_4/loss_8/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_4/loss_8/neg_item_bias_grad/Size4gradients_4/loss_8/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_4/loss_8/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_4/loss_8/neg_item_bias_grad/strided_sliceStridedSlice+gradients_4/loss_8/neg_item_bias_grad/Shape9gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_1;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_4/loss_8/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_4/loss_8/neg_item_bias_grad/concatConcatV20gradients_4/loss_8/neg_item_bias_grad/ExpandDims3gradients_4/loss_8/neg_item_bias_grad/strided_slice1gradients_4/loss_8/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ґ
-gradients_4/loss_8/neg_item_bias_grad/ReshapeReshapegradients_4/AddN_1,gradients_4/loss_8/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
 
/gradients_4/loss_8/neg_item_bias_grad/Reshape_1Reshape placeholders_4/sampled_neg_items0gradients_4/loss_8/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
m
!gradients_4/loss_8/mul_grad/ShapeShapeloss_8/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_4/loss_8/mul_grad/Shape_1Shape
loss_8/sub*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_4/loss_8/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/mul_grad/Shape#gradients_4/loss_8/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_4/loss_8/mul_grad/mulMul gradients_4/loss_8/Sum_grad/Tile
loss_8/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_4/loss_8/mul_grad/SumSumgradients_4/loss_8/mul_grad/mul1gradients_4/loss_8/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_4/loss_8/mul_grad/ReshapeReshapegradients_4/loss_8/mul_grad/Sum!gradients_4/loss_8/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
К
!gradients_4/loss_8/mul_grad/mul_1Mulloss_8/users gradients_4/loss_8/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_4/loss_8/mul_grad/Sum_1Sum!gradients_4/loss_8/mul_grad/mul_13gradients_4/loss_8/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_4/loss_8/mul_grad/Reshape_1Reshape!gradients_4/loss_8/mul_grad/Sum_1#gradients_4/loss_8/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_4/loss_8/mul_grad/tuple/group_depsNoOp$^gradients_4/loss_8/mul_grad/Reshape&^gradients_4/loss_8/mul_grad/Reshape_1
ю
4gradients_4/loss_8/mul_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/mul_grad/Reshape-^gradients_4/loss_8/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_4/loss_8/mul_grad/Reshape
Д
6gradients_4/loss_8/mul_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/mul_grad/Reshape_1-^gradients_4/loss_8/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_grad/Reshape_1
Y
gradients_4/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_4/concatConcatV2-gradients_4/loss_8/pos_item_bias_grad/Reshape-gradients_4/loss_8/neg_item_bias_grad/Reshapegradients_4/concat/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_4/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_4/concat_1ConcatV2/gradients_4/loss_8/pos_item_bias_grad/Reshape_1/gradients_4/loss_8/neg_item_bias_grad/Reshape_1gradients_4/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
щ
gradients_4/AddN_2AddN4gradients_4/loss_8/pow_grad/tuple/control_dependency4gradients_4/loss_8/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*6
_class,
*(loc:@gradients_4/loss_8/pow_grad/Reshape
°
#gradients_4/loss_8/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_4/user_factors
y
"gradients_4/loss_8/users_grad/SizeSizeplaceholders_4/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_4/loss_8/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_4/loss_8/users_grad/ExpandDims
ExpandDims"gradients_4/loss_8/users_grad/Size,gradients_4/loss_8/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_4/loss_8/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_4/loss_8/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_4/loss_8/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_4/loss_8/users_grad/strided_sliceStridedSlice#gradients_4/loss_8/users_grad/Shape1gradients_4/loss_8/users_grad/strided_slice/stack3gradients_4/loss_8/users_grad/strided_slice/stack_13gradients_4/loss_8/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_4/loss_8/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_4/loss_8/users_grad/concatConcatV2(gradients_4/loss_8/users_grad/ExpandDims+gradients_4/loss_8/users_grad/strided_slice)gradients_4/loss_8/users_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
≥
%gradients_4/loss_8/users_grad/ReshapeReshapegradients_4/AddN_2$gradients_4/loss_8/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
ґ
'gradients_4/loss_8/users_grad/Reshape_1Reshapeplaceholders_4/sampled_users(gradients_4/loss_8/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
q
!gradients_4/loss_8/sub_grad/ShapeShapeloss_8/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_4/loss_8/sub_grad/Shape_1Shapeloss_8/neg_items*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_4/loss_8/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/sub_grad/Shape#gradients_4/loss_8/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_4/loss_8/sub_grad/SumSum6gradients_4/loss_8/mul_grad/tuple/control_dependency_11gradients_4/loss_8/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_4/loss_8/sub_grad/ReshapeReshapegradients_4/loss_8/sub_grad/Sum!gradients_4/loss_8/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
’
!gradients_4/loss_8/sub_grad/Sum_1Sum6gradients_4/loss_8/mul_grad/tuple/control_dependency_13gradients_4/loss_8/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_4/loss_8/sub_grad/NegNeg!gradients_4/loss_8/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_4/loss_8/sub_grad/Reshape_1Reshapegradients_4/loss_8/sub_grad/Neg#gradients_4/loss_8/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
T0*
Tshape0
В
,gradients_4/loss_8/sub_grad/tuple/group_depsNoOp$^gradients_4/loss_8/sub_grad/Reshape&^gradients_4/loss_8/sub_grad/Reshape_1
ю
4gradients_4/loss_8/sub_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/sub_grad/Reshape-^gradients_4/loss_8/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_4/loss_8/sub_grad/Reshape
Д
6gradients_4/loss_8/sub_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/sub_grad/Reshape_1-^gradients_4/loss_8/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/sub_grad/Reshape_1
э
gradients_4/AddN_3AddN6gradients_4/loss_8/pow_1_grad/tuple/control_dependency4gradients_4/loss_8/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_1_grad/Reshape
•
'gradients_4/loss_8/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_4/item_factors
Б
&gradients_4/loss_8/pos_items_grad/SizeSize placeholders_4/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_4/loss_8/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_4/loss_8/pos_items_grad/ExpandDims
ExpandDims&gradients_4/loss_8/pos_items_grad/Size0gradients_4/loss_8/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_4/loss_8/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_4/loss_8/pos_items_grad/strided_sliceStridedSlice'gradients_4/loss_8/pos_items_grad/Shape5gradients_4/loss_8/pos_items_grad/strided_slice/stack7gradients_4/loss_8/pos_items_grad/strided_slice/stack_17gradients_4/loss_8/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_4/loss_8/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_4/loss_8/pos_items_grad/concatConcatV2,gradients_4/loss_8/pos_items_grad/ExpandDims/gradients_4/loss_8/pos_items_grad/strided_slice-gradients_4/loss_8/pos_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_4/loss_8/pos_items_grad/ReshapeReshapegradients_4/AddN_3(gradients_4/loss_8/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_4/loss_8/pos_items_grad/Reshape_1Reshape placeholders_4/sampled_pos_items,gradients_4/loss_8/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
€
gradients_4/AddN_4AddN6gradients_4/loss_8/pow_3_grad/tuple/control_dependency6gradients_4/loss_8/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
N*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_3_grad/Reshape
•
'gradients_4/loss_8/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_4/item_factors
Б
&gradients_4/loss_8/neg_items_grad/SizeSize placeholders_4/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_4/loss_8/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_4/loss_8/neg_items_grad/ExpandDims
ExpandDims&gradients_4/loss_8/neg_items_grad/Size0gradients_4/loss_8/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_4/loss_8/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_4/loss_8/neg_items_grad/strided_sliceStridedSlice'gradients_4/loss_8/neg_items_grad/Shape5gradients_4/loss_8/neg_items_grad/strided_slice/stack7gradients_4/loss_8/neg_items_grad/strided_slice/stack_17gradients_4/loss_8/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_4/loss_8/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_4/loss_8/neg_items_grad/concatConcatV2,gradients_4/loss_8/neg_items_grad/ExpandDims/gradients_4/loss_8/neg_items_grad/strided_slice-gradients_4/loss_8/neg_items_grad/concat/axis*
_output_shapes
:*
N*
T0*

Tidx0
ї
)gradients_4/loss_8/neg_items_grad/ReshapeReshapegradients_4/AddN_4(gradients_4/loss_8/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
Tshape0
¬
+gradients_4/loss_8/neg_items_grad/Reshape_1Reshape placeholders_4/sampled_neg_items,gradients_4/loss_8/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
T0*
Tshape0
[
gradients_4/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_4/concat_2ConcatV2)gradients_4/loss_8/pos_items_grad/Reshape)gradients_4/loss_8/neg_items_grad/Reshapegradients_4/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
N*
T0*

Tidx0
[
gradients_4/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_4/concat_3ConcatV2+gradients_4/loss_8/pos_items_grad/Reshape_1+gradients_4/loss_8/neg_items_grad/Reshape_1gradients_4/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
N*
T0*

Tidx0
d
GradientDescent_4/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_4/update_variables_4/user_factors/mulMul%gradients_4/loss_8/users_grad/ReshapeGradientDescent_4/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_4/user_factors
Њ
<GradientDescent_4/update_variables_4/user_factors/ScatterSub
ScatterSubvariables_4/user_factors'gradients_4/loss_8/users_grad/Reshape_15GradientDescent_4/update_variables_4/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_4/user_factors
џ
5GradientDescent_4/update_variables_4/item_factors/mulMulgradients_4/concat_2GradientDescent_4/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_4/item_factors
Ђ
<GradientDescent_4/update_variables_4/item_factors/ScatterSub
ScatterSubvariables_4/item_factorsgradients_4/concat_35GradientDescent_4/update_variables_4/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_4/item_factors
∆
2GradientDescent_4/update_variables_4/item_bias/mulMulgradients_4/concatGradientDescent_4/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_4/item_bias
Ы
9GradientDescent_4/update_variables_4/item_bias/ScatterSub
ScatterSubvariables_4/item_biasgradients_4/concat_12GradientDescent_4/update_variables_4/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_4/item_bias
”
GradientDescent_4NoOp=^GradientDescent_4/update_variables_4/user_factors/ScatterSub=^GradientDescent_4/update_variables_4/item_factors/ScatterSub:^GradientDescent_4/update_variables_4/item_bias/ScatterSub
R
loss_9/tagsConst*
valueB Bloss_9*
_output_shapes
: *
dtype0
S
loss_9ScalarSummaryloss_9/tagsloss_8/sub_2*
_output_shapes
: *
T0
m
Merge_4/MergeSummaryMergeSummaryloss_1loss_3loss_5loss_7loss_9*
_output_shapes
: *
N
ч
init_4NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign ^variables_2/user_factors/Assign ^variables_2/item_factors/Assign^variables_2/item_bias/Assign ^variables_3/user_factors/Assign ^variables_3/item_factors/Assign^variables_3/item_bias/Assign ^variables_4/user_factors/Assign ^variables_4/item_factors/Assign^variables_4/item_bias/Assign",hk”<'     WJ£Ы	LpЭу]÷AJѓќ
яљ
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
2	АР
x
Assign
ref"TА

value"T

output_ref"TА"	
Ttype"
validate_shapebool("
use_lockingbool(Ш
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
М
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
?
GreaterEqual
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
<
	LessEqual
x"T
y"T
z
"
Ttype:
2		
+
Log
x"T
y"T"
Ttype:	
2


LogicalNot
x

y

:
Maximum
x"T
y"T
z"T"
Ttype:	
2	Р
8
MergeSummary
inputs*N
summary"
Nint(0
:
Minimum
x"T
y"T
z"T"
Ttype:	
2	Р
<
Mul
x"T
y"T
z"T"
Ttype:
2	Р
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
Ґ

ScatterSub
ref"TА
indices"Tindices
updates"T

output_ref"TА"
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
/
Sigmoid
x"T
y"T"
Ttype:	
2
;
SigmoidGrad
x"T
y"T
z"T"
Ttype:	
2
O
Size

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
ц
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
Й
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
2	И
s

VariableV2
ref"dtypeА"
shapeshape"
dtypetype"
	containerstring "
shared_namestring И
&
	ZerosLike
x"T
y"T"	
Ttype*1.1.02v1.1.0-rc0-61-g1ec6ed5•Ь
h
placeholders/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
l
placeholders/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
l
placeholders/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
q
 variables/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
d
variables/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
f
!variables/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
≥
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
Ю
variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	д
*
T0
М
variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	д
*
T0
s
"variables/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
§
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Т
variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
М
variables/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
ў
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*)
_class
loc:@variables/user_factors
Ф
variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	д
*
T0*)
_class
loc:@variables/user_factors
М
variables/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
џ
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*)
_class
loc:@variables/item_factors
Ф
variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	з
*
T0*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Б
variables/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
Ѕ
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*&
_class
loc:@variables/item_bias
З
variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:з*
T0*&
_class
loc:@variables/item_bias
≠

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
µ
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
µ
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
≤
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
≤
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:€€€€€€€€€
*
T0
\
loss/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
А
loss/SumSumloss/mulloss/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:€€€€€€€€€*
T0
O
loss/SigmoidSigmoidloss/add*#
_output_shapes
:€€€€€€€€€*
T0
a
loss/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0

loss/clip_by_value/MinimumMinimumloss/Sigmoidloss/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Y
loss/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
}
loss/clip_by_valueMaximumloss/clip_by_value/Minimumloss/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
Q
loss/LogLogloss/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
T

loss/ConstConst*
valueB: *
_output_shapes
:*
dtype0
e

loss/Sum_1Sumloss/Log
loss/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
O

loss/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
Y
loss/powPow
loss/users
loss/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
]
loss/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
g

loss/Sum_2Sumloss/powloss/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
_output_shapes
: *
T0
Q
loss/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
]
loss/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
_output_shapes
: *
T0
Q
loss/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
V
loss/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
J

loss/add_1Add
loss/mul_2
loss/Sum_4*
_output_shapes
: *
T0
Q
loss/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
]
loss/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
_output_shapes
: *
T0
Q
loss/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
V
loss/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
J

loss/add_2Add
loss/mul_3
loss/Sum_6*
_output_shapes
: *
T0
J

loss/add_3Add
loss/mul_1
loss/add_1*
_output_shapes
: *
T0
J

loss/add_4Add
loss/add_3
loss/add_2*
_output_shapes
: *
T0
J

loss/sub_2Sub
loss/add_4
loss/Sum_1*
_output_shapes
: *
T0
R
gradients/ShapeConst*
valueB *
_output_shapes
: *
dtype0
T
gradients/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
Y
gradients/FillFillgradients/Shapegradients/Const*
_output_shapes
: *
T0
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
•
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
©
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Я
#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
е
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
л
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
…
gradients/loss/add_4_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
_output_shapes
: *
Tshape0*
T0
Ќ
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
е
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
л
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
Њ
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
g
gradients/loss/Sum_1_grad/ShapeShapeloss/Log*
_output_shapes
:*
T0*
out_type0
™
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
…
gradients/loss/add_3_grad/SumSum2gradients/loss/add_4_grad/tuple/control_dependency/gradients/loss/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
Ќ
gradients/loss/add_3_grad/Sum_1Sum2gradients/loss/add_4_grad/tuple/control_dependency1gradients/loss/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
е
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
л
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ћ
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ѕ
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
е
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
л
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1
У
"gradients/loss/Log_grad/Reciprocal
Reciprocalloss/clip_by_value^gradients/loss/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
Ф
gradients/loss/Log_grad/mulMulgradients/loss/Sum_1_grad/Tile"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Е
gradients/loss/mul_1_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
і
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
Й
gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
Ї
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
е
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
л
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ћ
gradients/loss/add_1_grad/SumSum4gradients/loss/add_3_grad/tuple/control_dependency_1/gradients/loss/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ѕ
gradients/loss/add_1_grad/Sum_1Sum4gradients/loss/add_3_grad/tuple/control_dependency_11gradients/loss/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
е
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
л
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Е
gradients/loss/mul_3_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
і
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
Й
gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
Ї
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
е
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
л
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
Њ
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
_output_shapes
:*
T0*
out_type0
™
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
Б
'gradients/loss/clip_by_value_grad/ShapeShapeloss/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
l
)gradients/loss/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Д
)gradients/loss/clip_by_value_grad/Shape_2Shapegradients/loss/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
r
-gradients/loss/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
Ј
'gradients/loss/clip_by_value_grad/zerosFill)gradients/loss/clip_by_value_grad/Shape_2-gradients/loss/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ю
.gradients/loss/clip_by_value_grad/GreaterEqualGreaterEqualloss/clip_by_value/Minimumloss/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
б
7gradients/loss/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs'gradients/loss/clip_by_value_grad/Shape)gradients/loss/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
÷
(gradients/loss/clip_by_value_grad/SelectSelect.gradients/loss/clip_by_value_grad/GreaterEqualgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
П
,gradients/loss/clip_by_value_grad/LogicalNot
LogicalNot.gradients/loss/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
÷
*gradients/loss/clip_by_value_grad/Select_1Select,gradients/loss/clip_by_value_grad/LogicalNotgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
ѕ
%gradients/loss/clip_by_value_grad/SumSum(gradients/loss/clip_by_value_grad/Select7gradients/loss/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ј
)gradients/loss/clip_by_value_grad/ReshapeReshape%gradients/loss/clip_by_value_grad/Sum'gradients/loss/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
’
'gradients/loss/clip_by_value_grad/Sum_1Sum*gradients/loss/clip_by_value_grad/Select_19gradients/loss/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
є
+gradients/loss/clip_by_value_grad/Reshape_1Reshape'gradients/loss/clip_by_value_grad/Sum_1)gradients/loss/clip_by_value_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
Ф
2gradients/loss/clip_by_value_grad/tuple/group_depsNoOp*^gradients/loss/clip_by_value_grad/Reshape,^gradients/loss/clip_by_value_grad/Reshape_1
Т
:gradients/loss/clip_by_value_grad/tuple/control_dependencyIdentity)gradients/loss/clip_by_value_grad/Reshape3^gradients/loss/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*<
_class2
0.loc:@gradients/loss/clip_by_value_grad/Reshape
Л
<gradients/loss/clip_by_value_grad/tuple/control_dependency_1Identity+gradients/loss/clip_by_value_grad/Reshape_13^gradients/loss/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*>
_class4
20loc:@gradients/loss/clip_by_value_grad/Reshape_1
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
¬
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
_output_shapes
:*
T0*
out_type0
Ѓ
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Е
gradients/loss/mul_2_grad/mulMul2gradients/loss/add_1_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
і
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
Й
gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
Ї
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
е
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
л
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
Њ
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_1_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
_output_shapes
:*
T0*
out_type0
™
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
¬
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
_output_shapes
:*
T0*
out_type0
Ѓ
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
А
gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Т
gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
ґ
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
ј
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
А
gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
Ч
gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
Ї
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
т
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
л
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1
{
/gradients/loss/clip_by_value/Minimum_grad/ShapeShapeloss/Sigmoid*
_output_shapes
:*
T0*
out_type0
t
1gradients/loss/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Ђ
1gradients/loss/clip_by_value/Minimum_grad/Shape_2Shape:gradients/loss/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
z
5gradients/loss/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
ѕ
/gradients/loss/clip_by_value/Minimum_grad/zerosFill1gradients/loss/clip_by_value/Minimum_grad/Shape_25gradients/loss/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ъ
3gradients/loss/clip_by_value/Minimum_grad/LessEqual	LessEqualloss/Sigmoidloss/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
щ
?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs/gradients/loss/clip_by_value/Minimum_grad/Shape1gradients/loss/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
0gradients/loss/clip_by_value/Minimum_grad/SelectSelect3gradients/loss/clip_by_value/Minimum_grad/LessEqual:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ь
4gradients/loss/clip_by_value/Minimum_grad/LogicalNot
LogicalNot3gradients/loss/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Н
2gradients/loss/clip_by_value/Minimum_grad/Select_1Select4gradients/loss/clip_by_value/Minimum_grad/LogicalNot:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
з
-gradients/loss/clip_by_value/Minimum_grad/SumSum0gradients/loss/clip_by_value/Minimum_grad/Select?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ў
1gradients/loss/clip_by_value/Minimum_grad/ReshapeReshape-gradients/loss/clip_by_value/Minimum_grad/Sum/gradients/loss/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
н
/gradients/loss/clip_by_value/Minimum_grad/Sum_1Sum2gradients/loss/clip_by_value/Minimum_grad/Select_1Agradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
—
3gradients/loss/clip_by_value/Minimum_grad/Reshape_1Reshape/gradients/loss/clip_by_value/Minimum_grad/Sum_11gradients/loss/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
ђ
:gradients/loss/clip_by_value/Minimum_grad/tuple/group_depsNoOp2^gradients/loss/clip_by_value/Minimum_grad/Reshape4^gradients/loss/clip_by_value/Minimum_grad/Reshape_1
≤
Bgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity1gradients/loss/clip_by_value/Minimum_grad/Reshape;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*D
_class:
86loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape
Ђ
Dgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity3gradients/loss/clip_by_value/Minimum_grad/Reshape_1;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*F
_class<
:8loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape_1
g
gradients/loss/pow_grad/ShapeShape
loss/users*
_output_shapes
:*
T0*
out_type0
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
√
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
А
gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
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
:€€€€€€€€€
*
T0
Р
gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
∞
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
¶
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Л
gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:€€€€€€€€€
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
А
gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:€€€€€€€€€
*
T0
Х
gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
і
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ы
!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
о
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
г
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
¬
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
_output_shapes
:*
T0*
out_type0
Ѓ
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
А
gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Т
gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
ґ
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
ј
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
А
gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
Ч
gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
Ї
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
т
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
л
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
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Д
gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ц
gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
ґ
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ђ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
ƒ
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
Д
gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
Ы
gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
ц
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
л
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1
ґ
'gradients/loss/Sigmoid_grad/SigmoidGradSigmoidGradloss/SigmoidBgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
_output_shapes
:*
T0*
out_type0
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
…
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Д
gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0
Е
gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ц
gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
ґ
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ђ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
У
!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
ƒ
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
Д
gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
Ы
gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
°
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
ц
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
л
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
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
√
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ї
gradients/loss/add_grad/SumSum'gradients/loss/Sigmoid_grad/SigmoidGrad-gradients/loss/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ґ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
Њ
gradients/loss/add_grad/Sum_1Sum'gradients/loss/Sigmoid_grad/SigmoidGrad/gradients/loss/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
к
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
р
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
…
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
«
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
®
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
Ћ
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
_output_shapes
:*
T0
ђ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
т
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
ш
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
gradients/loss/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
Г
gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
ґ
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
К
gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
ж
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
T0*
N
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ґ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
С
 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
ґ
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
_output_shapes
:*
Tshape0*
T0
Ђ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
л
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
Ъ
'gradients/loss/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*&
_class
loc:@variables/item_bias

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
•
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
™
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
ј
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
п
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
T0*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
Ъ
'gradients/loss/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*&
_class
loc:@variables/item_bias

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
•
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ђ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
ј
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
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
√
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ѓ
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
¶
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
А
gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
і
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ђ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
о
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
ф
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1
W
gradients/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ћ
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
Y
gradients/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
‘
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
л
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
Ы
gradients/loss/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*)
_class
loc:@variables/user_factors
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
_output_shapes
: *
T0*
out_type0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≠
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
€
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
№
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
©
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
ђ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
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
√
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
≈
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
¶
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
…
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
_output_shapes
:*
T0
™
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
о
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
ф
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
п
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
Я
#gradients/loss/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*)
_class
loc:@variables/item_factors
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
±
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
Є
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
с
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
T0*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
Я
#gradients/loss/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*)
_class
loc:@variables/item_factors
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
±
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
Є
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
Y
gradients/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
’
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
N*

Tidx0
Y
gradients/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
ћ
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
b
GradientDescent/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
а
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*)
_class
loc:@variables/user_factors
Ѓ
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*)
_class
loc:@variables/user_factors
—
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*)
_class
loc:@variables/item_factors
Э
8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*)
_class
loc:@variables/item_factors
Љ
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*&
_class
loc:@variables/item_bias
Н
5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*&
_class
loc:@variables/item_bias
≈
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
_output_shapes
: *
dtype0
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
placeholders_1/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_1/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_1/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_1/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_1/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_1/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_1/truncated_normal/TruncatedNormalTruncatedNormal"variables_1/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_1/truncated_normal/mulMul,variables_1/truncated_normal/TruncatedNormal#variables_1/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_1/truncated_normalAdd variables_1/truncated_normal/mul!variables_1/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_1/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_1/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_1/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_1/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_1/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_1/truncated_normal_1/mulMul.variables_1/truncated_normal_1/TruncatedNormal%variables_1/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_1/truncated_normal_1Add"variables_1/truncated_normal_1/mul#variables_1/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_1/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_1/user_factors/AssignAssignvariables_1/user_factorsvariables_1/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_1/user_factors
Ъ
variables_1/user_factors/readIdentityvariables_1/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_1/user_factors
О
variables_1/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_1/item_factors/AssignAssignvariables_1/item_factorsvariables_1/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_1/item_factors
Ъ
variables_1/item_factors/readIdentityvariables_1/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_1/item_factors
`
variables_1/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_1/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_1/item_bias/AssignAssignvariables_1/item_biasvariables_1/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_1/item_bias
Н
variables_1/item_bias/readIdentityvariables_1/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_1/item_bias
≥
loss_2/usersGathervariables_1/user_factors/readplaceholders_1/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_2/pos_itemsGathervariables_1/item_factors/read placeholders_1/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_2/neg_itemsGathervariables_1/item_factors/read placeholders_1/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_2/pos_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_2/neg_item_biasGathervariables_1/item_bias/read placeholders_1/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_2/subSubloss_2/pos_itemsloss_2/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_2/mulMulloss_2/users
loss_2/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_2/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_2/SumSum
loss_2/mulloss_2/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_2/sub_1Subloss_2/pos_item_biasloss_2/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_2/addAddloss_2/sub_1
loss_2/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_2/SigmoidSigmoid
loss_2/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_2/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_2/clip_by_value/MinimumMinimumloss_2/Sigmoidloss_2/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_2/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_2/clip_by_valueMaximumloss_2/clip_by_value/Minimumloss_2/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_2/LogLogloss_2/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_2/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_2/Sum_1Sum
loss_2/Logloss_2/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_2/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_2/powPowloss_2/usersloss_2/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_2/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_2/Sum_2Sum
loss_2/powloss_2/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_2/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_2/mul_1Mulloss_2/mul_1/xloss_2/Sum_2*
_output_shapes
: *
T0
S
loss_2/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_1Powloss_2/pos_itemsloss_2/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_2/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_2/Sum_3Sumloss_2/pow_1loss_2/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_2/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_2/mul_2Mulloss_2/mul_2/xloss_2/Sum_3*
_output_shapes
: *
T0
S
loss_2/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_2Powloss_2/pos_item_biasloss_2/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_2/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_2/Sum_4Sumloss_2/pow_2loss_2/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_2/add_1Addloss_2/mul_2loss_2/Sum_4*
_output_shapes
: *
T0
S
loss_2/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_3Powloss_2/neg_itemsloss_2/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_2/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_2/Sum_5Sumloss_2/pow_3loss_2/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_2/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_2/mul_3Mulloss_2/mul_3/xloss_2/Sum_5*
_output_shapes
: *
T0
S
loss_2/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_2/pow_4Powloss_2/neg_item_biasloss_2/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_2/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_2/Sum_6Sumloss_2/pow_4loss_2/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_2/add_2Addloss_2/mul_3loss_2/Sum_6*
_output_shapes
: *
T0
P
loss_2/add_3Addloss_2/mul_1loss_2/add_1*
_output_shapes
: *
T0
P
loss_2/add_4Addloss_2/add_3loss_2/add_2*
_output_shapes
: *
T0
P
loss_2/sub_2Subloss_2/add_4loss_2/Sum_1*
_output_shapes
: *
T0
T
gradients_1/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_1/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_1/FillFillgradients_1/Shapegradients_1/Const*
_output_shapes
: *
T0
f
#gradients_1/loss_2/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_2_grad/Shape%gradients_1/loss_2/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_1/loss_2/sub_2_grad/SumSumgradients_1/Fill3gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/sub_2_grad/ReshapeReshape!gradients_1/loss_2/sub_2_grad/Sum#gradients_1/loss_2/sub_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
≥
#gradients_1/loss_2/sub_2_grad/Sum_1Sumgradients_1/Fill5gradients_1/loss_2/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_1/loss_2/sub_2_grad/NegNeg#gradients_1/loss_2/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_1/loss_2/sub_2_grad/Reshape_1Reshape!gradients_1/loss_2/sub_2_grad/Neg%gradients_1/loss_2/sub_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/sub_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_2_grad/Reshape(^gradients_1/loss_2/sub_2_grad/Reshape_1
х
6gradients_1/loss_2/sub_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_2_grad/Reshape/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_2_grad/Reshape
ы
8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_2_grad/Reshape_1/^gradients_1/loss_2/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/sub_2_grad/Reshape_1
f
#gradients_1/loss_2/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_4_grad/Shape%gradients_1/loss_2/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_1/loss_2/add_4_grad/SumSum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency3gradients_1/loss_2/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_4_grad/ReshapeReshape!gradients_1/loss_2/add_4_grad/Sum#gradients_1/loss_2/add_4_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_1/loss_2/add_4_grad/Sum_1Sum6gradients_1/loss_2/sub_2_grad/tuple/control_dependency5gradients_1/loss_2/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_4_grad/Reshape_1Reshape#gradients_1/loss_2/add_4_grad/Sum_1%gradients_1/loss_2/add_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/add_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_4_grad/Reshape(^gradients_1/loss_2/add_4_grad/Reshape_1
х
6gradients_1/loss_2/add_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_4_grad/Reshape/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_4_grad/Reshape
ы
8gradients_1/loss_2/add_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_4_grad/Reshape_1/^gradients_1/loss_2/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_4_grad/Reshape_1
u
+gradients_1/loss_2/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_1/loss_2/Sum_1_grad/ReshapeReshape8gradients_1/loss_2/sub_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_1_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
m
#gradients_1/loss_2/Sum_1_grad/ShapeShape
loss_2/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_1/loss_2/Sum_1_grad/TileTile%gradients_1/loss_2/Sum_1_grad/Reshape#gradients_1/loss_2/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_1/loss_2/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_3_grad/Shape%gradients_1/loss_2/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_1/loss_2/add_3_grad/SumSum6gradients_1/loss_2/add_4_grad/tuple/control_dependency3gradients_1/loss_2/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_3_grad/ReshapeReshape!gradients_1/loss_2/add_3_grad/Sum#gradients_1/loss_2/add_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_1/loss_2/add_3_grad/Sum_1Sum6gradients_1/loss_2/add_4_grad/tuple/control_dependency5gradients_1/loss_2/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_3_grad/Reshape_1Reshape#gradients_1/loss_2/add_3_grad/Sum_1%gradients_1/loss_2/add_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/add_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_3_grad/Reshape(^gradients_1/loss_2/add_3_grad/Reshape_1
х
6gradients_1/loss_2/add_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_3_grad/Reshape/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_3_grad/Reshape
ы
8gradients_1/loss_2/add_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_3_grad/Reshape_1/^gradients_1/loss_2/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_3_grad/Reshape_1
f
#gradients_1/loss_2/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_2_grad/Shape%gradients_1/loss_2/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_1/loss_2/add_2_grad/SumSum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_13gradients_1/loss_2/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_2_grad/ReshapeReshape!gradients_1/loss_2/add_2_grad/Sum#gradients_1/loss_2/add_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_1/loss_2/add_2_grad/Sum_1Sum8gradients_1/loss_2/add_4_grad/tuple/control_dependency_15gradients_1/loss_2/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_2_grad/Reshape_1Reshape#gradients_1/loss_2/add_2_grad/Sum_1%gradients_1/loss_2/add_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/add_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_2_grad/Reshape(^gradients_1/loss_2/add_2_grad/Reshape_1
х
6gradients_1/loss_2/add_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_2_grad/Reshape/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_2_grad/Reshape
ы
8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_2_grad/Reshape_1/^gradients_1/loss_2/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_2_grad/Reshape_1
Э
&gradients_1/loss_2/Log_grad/Reciprocal
Reciprocalloss_2/clip_by_value#^gradients_1/loss_2/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_1/loss_2/Log_grad/mulMul"gradients_1/loss_2/Sum_1_grad/Tile&gradients_1/loss_2/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_1/loss_2/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_1_grad/Shape%gradients_1/loss_2/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_1/loss_2/mul_1_grad/mulMul6gradients_1/loss_2/add_3_grad/tuple/control_dependencyloss_2/Sum_2*
_output_shapes
: *
T0
ј
!gradients_1/loss_2/mul_1_grad/SumSum!gradients_1/loss_2/mul_1_grad/mul3gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/mul_1_grad/ReshapeReshape!gradients_1/loss_2/mul_1_grad/Sum#gradients_1/loss_2/mul_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_1/loss_2/mul_1_grad/mul_1Mulloss_2/mul_1/x6gradients_1/loss_2/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_1/loss_2/mul_1_grad/Sum_1Sum#gradients_1/loss_2/mul_1_grad/mul_15gradients_1/loss_2/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/mul_1_grad/Reshape_1Reshape#gradients_1/loss_2/mul_1_grad/Sum_1%gradients_1/loss_2/mul_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/mul_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_1_grad/Reshape(^gradients_1/loss_2/mul_1_grad/Reshape_1
х
6gradients_1/loss_2/mul_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_1_grad/Reshape/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_1_grad/Reshape
ы
8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_1_grad/Reshape_1/^gradients_1/loss_2/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_1_grad/Reshape_1
f
#gradients_1/loss_2/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/add_1_grad/Shape%gradients_1/loss_2/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_1/loss_2/add_1_grad/SumSum8gradients_1/loss_2/add_3_grad/tuple/control_dependency_13gradients_1/loss_2/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/add_1_grad/ReshapeReshape!gradients_1/loss_2/add_1_grad/Sum#gradients_1/loss_2/add_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_1/loss_2/add_1_grad/Sum_1Sum8gradients_1/loss_2/add_3_grad/tuple/control_dependency_15gradients_1/loss_2/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/add_1_grad/Reshape_1Reshape#gradients_1/loss_2/add_1_grad/Sum_1%gradients_1/loss_2/add_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/add_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/add_1_grad/Reshape(^gradients_1/loss_2/add_1_grad/Reshape_1
х
6gradients_1/loss_2/add_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/add_1_grad/Reshape/^gradients_1/loss_2/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/add_1_grad/Reshape
ы
8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/add_1_grad/Reshape_1/^gradients_1/loss_2/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/add_1_grad/Reshape_1
f
#gradients_1/loss_2/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_3_grad/Shape%gradients_1/loss_2/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_1/loss_2/mul_3_grad/mulMul6gradients_1/loss_2/add_2_grad/tuple/control_dependencyloss_2/Sum_5*
_output_shapes
: *
T0
ј
!gradients_1/loss_2/mul_3_grad/SumSum!gradients_1/loss_2/mul_3_grad/mul3gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/mul_3_grad/ReshapeReshape!gradients_1/loss_2/mul_3_grad/Sum#gradients_1/loss_2/mul_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_1/loss_2/mul_3_grad/mul_1Mulloss_2/mul_3/x6gradients_1/loss_2/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_1/loss_2/mul_3_grad/Sum_1Sum#gradients_1/loss_2/mul_3_grad/mul_15gradients_1/loss_2/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/mul_3_grad/Reshape_1Reshape#gradients_1/loss_2/mul_3_grad/Sum_1%gradients_1/loss_2/mul_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/mul_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_3_grad/Reshape(^gradients_1/loss_2/mul_3_grad/Reshape_1
х
6gradients_1/loss_2/mul_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_3_grad/Reshape/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_3_grad/Reshape
ы
8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_3_grad/Reshape_1/^gradients_1/loss_2/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_3_grad/Reshape_1
u
+gradients_1/loss_2/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_1/loss_2/Sum_6_grad/ReshapeReshape8gradients_1/loss_2/add_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_6_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_1/loss_2/Sum_6_grad/ShapeShapeloss_2/pow_4*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_1/loss_2/Sum_6_grad/TileTile%gradients_1/loss_2/Sum_6_grad/Reshape#gradients_1/loss_2/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_1/loss_2/clip_by_value_grad/ShapeShapeloss_2/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_1/loss_2/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_1/loss_2/clip_by_value_grad/Shape_2Shapegradients_1/loss_2/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_1/loss_2/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_1/loss_2/clip_by_value_grad/zerosFill-gradients_1/loss_2/clip_by_value_grad/Shape_21gradients_1/loss_2/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_1/loss_2/clip_by_value_grad/GreaterEqualGreaterEqualloss_2/clip_by_value/Minimumloss_2/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_1/loss_2/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_1/loss_2/clip_by_value_grad/Shape-gradients_1/loss_2/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_1/loss_2/clip_by_value_grad/SelectSelect2gradients_1/loss_2/clip_by_value_grad/GreaterEqualgradients_1/loss_2/Log_grad/mul+gradients_1/loss_2/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_1/loss_2/clip_by_value_grad/LogicalNot
LogicalNot2gradients_1/loss_2/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_1/loss_2/clip_by_value_grad/Select_1Select0gradients_1/loss_2/clip_by_value_grad/LogicalNotgradients_1/loss_2/Log_grad/mul+gradients_1/loss_2/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_1/loss_2/clip_by_value_grad/SumSum,gradients_1/loss_2/clip_by_value_grad/Select;gradients_1/loss_2/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_1/loss_2/clip_by_value_grad/ReshapeReshape)gradients_1/loss_2/clip_by_value_grad/Sum+gradients_1/loss_2/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
б
+gradients_1/loss_2/clip_by_value_grad/Sum_1Sum.gradients_1/loss_2/clip_by_value_grad/Select_1=gradients_1/loss_2/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_1/loss_2/clip_by_value_grad/Reshape_1Reshape+gradients_1/loss_2/clip_by_value_grad/Sum_1-gradients_1/loss_2/clip_by_value_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
†
6gradients_1/loss_2/clip_by_value_grad/tuple/group_depsNoOp.^gradients_1/loss_2/clip_by_value_grad/Reshape0^gradients_1/loss_2/clip_by_value_grad/Reshape_1
Ґ
>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_1/loss_2/clip_by_value_grad/Reshape7^gradients_1/loss_2/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_1/loss_2/clip_by_value_grad/Reshape
Ы
@gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_1/loss_2/clip_by_value_grad/Reshape_17^gradients_1/loss_2/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_1/loss_2/clip_by_value_grad/Reshape_1
|
+gradients_1/loss_2/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_1/loss_2/Sum_2_grad/ReshapeReshape8gradients_1/loss_2/mul_1_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_2_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
m
#gradients_1/loss_2/Sum_2_grad/ShapeShape
loss_2/pow*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_1/loss_2/Sum_2_grad/TileTile%gradients_1/loss_2/Sum_2_grad/Reshape#gradients_1/loss_2/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_1/loss_2/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_1/loss_2/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/mul_2_grad/Shape%gradients_1/loss_2/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_1/loss_2/mul_2_grad/mulMul6gradients_1/loss_2/add_1_grad/tuple/control_dependencyloss_2/Sum_3*
_output_shapes
: *
T0
ј
!gradients_1/loss_2/mul_2_grad/SumSum!gradients_1/loss_2/mul_2_grad/mul3gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/mul_2_grad/ReshapeReshape!gradients_1/loss_2/mul_2_grad/Sum#gradients_1/loss_2/mul_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_1/loss_2/mul_2_grad/mul_1Mulloss_2/mul_2/x6gradients_1/loss_2/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_1/loss_2/mul_2_grad/Sum_1Sum#gradients_1/loss_2/mul_2_grad/mul_15gradients_1/loss_2/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/mul_2_grad/Reshape_1Reshape#gradients_1/loss_2/mul_2_grad/Sum_1%gradients_1/loss_2/mul_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/mul_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/mul_2_grad/Reshape(^gradients_1/loss_2/mul_2_grad/Reshape_1
х
6gradients_1/loss_2/mul_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/mul_2_grad/Reshape/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_2_grad/Reshape
ы
8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/mul_2_grad/Reshape_1/^gradients_1/loss_2/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/mul_2_grad/Reshape_1
u
+gradients_1/loss_2/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_1/loss_2/Sum_4_grad/ReshapeReshape8gradients_1/loss_2/add_1_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_4_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_1/loss_2/Sum_4_grad/ShapeShapeloss_2/pow_2*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_1/loss_2/Sum_4_grad/TileTile%gradients_1/loss_2/Sum_4_grad/Reshape#gradients_1/loss_2/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_1/loss_2/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_1/loss_2/Sum_5_grad/ReshapeReshape8gradients_1/loss_2/mul_3_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_5_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_1/loss_2/Sum_5_grad/ShapeShapeloss_2/pow_3*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_1/loss_2/Sum_5_grad/TileTile%gradients_1/loss_2/Sum_5_grad/Reshape#gradients_1/loss_2/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_1/loss_2/pow_4_grad/ShapeShapeloss_2/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_4_grad/Shape%gradients_1/loss_2/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_1/loss_2/pow_4_grad/mulMul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_1/loss_2/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_4_grad/subSubloss_2/pow_4/y#gradients_1/loss_2/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_4_grad/PowPowloss_2/neg_item_bias!gradients_1/loss_2/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_1/loss_2/pow_4_grad/mul_1Mul!gradients_1/loss_2/pow_4_grad/mul!gradients_1/loss_2/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_1/loss_2/pow_4_grad/SumSum#gradients_1/loss_2/pow_4_grad/mul_13gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/pow_4_grad/ReshapeReshape!gradients_1/loss_2/pow_4_grad/Sum#gradients_1/loss_2/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_1/loss_2/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_4_grad/GreaterGreaterloss_2/neg_item_bias'gradients_1/loss_2/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_1/loss_2/pow_4_grad/LogLogloss_2/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_1/loss_2/pow_4_grad/zeros_like	ZerosLikeloss_2/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_1/loss_2/pow_4_grad/SelectSelect%gradients_1/loss_2/pow_4_grad/Greater!gradients_1/loss_2/pow_4_grad/Log(gradients_1/loss_2/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_1/loss_2/pow_4_grad/mul_2Mul"gradients_1/loss_2/Sum_6_grad/Tileloss_2/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_1/loss_2/pow_4_grad/mul_3Mul#gradients_1/loss_2/pow_4_grad/mul_2$gradients_1/loss_2/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_1/loss_2/pow_4_grad/Sum_1Sum#gradients_1/loss_2/pow_4_grad/mul_35gradients_1/loss_2/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_4_grad/Reshape_1Reshape#gradients_1/loss_2/pow_4_grad/Sum_1%gradients_1/loss_2/pow_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/pow_4_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_4_grad/Reshape(^gradients_1/loss_2/pow_4_grad/Reshape_1
В
6gradients_1/loss_2/pow_4_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_4_grad/Reshape/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape
ы
8gradients_1/loss_2/pow_4_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_4_grad/Reshape_1/^gradients_1/loss_2/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_4_grad/Reshape_1
Б
3gradients_1/loss_2/clip_by_value/Minimum_grad/ShapeShapeloss_2/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_2Shape>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_1/loss_2/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_1/loss_2/clip_by_value/Minimum_grad/zerosFill5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_29gradients_1/loss_2/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_1/loss_2/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_2/Sigmoidloss_2/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_1/loss_2/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_1/loss_2/clip_by_value/Minimum_grad/Shape5gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_1/loss_2/clip_by_value/Minimum_grad/SelectSelect7gradients_1/loss_2/clip_by_value/Minimum_grad/LessEqual>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency3gradients_1/loss_2/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_1/loss_2/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_1/loss_2/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_1/loss_2/clip_by_value/Minimum_grad/Select_1Select8gradients_1/loss_2/clip_by_value/Minimum_grad/LogicalNot>gradients_1/loss_2/clip_by_value_grad/tuple/control_dependency3gradients_1/loss_2/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_1/loss_2/clip_by_value/Minimum_grad/SumSum4gradients_1/loss_2/clip_by_value/Minimum_grad/SelectCgradients_1/loss_2/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_1/loss_2/clip_by_value/Minimum_grad/ReshapeReshape1gradients_1/loss_2/clip_by_value/Minimum_grad/Sum3gradients_1/loss_2/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
щ
3gradients_1/loss_2/clip_by_value/Minimum_grad/Sum_1Sum6gradients_1/loss_2/clip_by_value/Minimum_grad/Select_1Egradients_1/loss_2/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_1/loss_2/clip_by_value/Minimum_grad/Sum_15gradients_1/loss_2/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
Є
>gradients_1/loss_2/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape8^gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_1/loss_2/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape?^gradients_1/loss_2/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_1/loss_2/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1?^gradients_1/loss_2/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_1/loss_2/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_1/loss_2/pow_grad/ShapeShapeloss_2/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_1/loss_2/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_1/loss_2/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/pow_grad/Shape#gradients_1/loss_2/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_1/loss_2/pow_grad/mulMul"gradients_1/loss_2/Sum_2_grad/Tileloss_2/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_1/loss_2/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_1/loss_2/pow_grad/subSubloss_2/pow/y!gradients_1/loss_2/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_1/loss_2/pow_grad/PowPowloss_2/usersgradients_1/loss_2/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_1/loss_2/pow_grad/mul_1Mulgradients_1/loss_2/pow_grad/mulgradients_1/loss_2/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_1/loss_2/pow_grad/SumSum!gradients_1/loss_2/pow_grad/mul_11gradients_1/loss_2/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_1/loss_2/pow_grad/ReshapeReshapegradients_1/loss_2/pow_grad/Sum!gradients_1/loss_2/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
j
%gradients_1/loss_2/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_1/loss_2/pow_grad/GreaterGreaterloss_2/users%gradients_1/loss_2/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_1/loss_2/pow_grad/LogLogloss_2/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_1/loss_2/pow_grad/zeros_like	ZerosLikeloss_2/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_1/loss_2/pow_grad/SelectSelect#gradients_1/loss_2/pow_grad/Greatergradients_1/loss_2/pow_grad/Log&gradients_1/loss_2/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_1/loss_2/pow_grad/mul_2Mul"gradients_1/loss_2/Sum_2_grad/Tile
loss_2/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_1/loss_2/pow_grad/mul_3Mul!gradients_1/loss_2/pow_grad/mul_2"gradients_1/loss_2/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_1/loss_2/pow_grad/Sum_1Sum!gradients_1/loss_2/pow_grad/mul_33gradients_1/loss_2/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_1/loss_2/pow_grad/Reshape_1Reshape!gradients_1/loss_2/pow_grad/Sum_1#gradients_1/loss_2/pow_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
В
,gradients_1/loss_2/pow_grad/tuple/group_depsNoOp$^gradients_1/loss_2/pow_grad/Reshape&^gradients_1/loss_2/pow_grad/Reshape_1
ю
4gradients_1/loss_2/pow_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/pow_grad/Reshape-^gradients_1/loss_2/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape
у
6gradients_1/loss_2/pow_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/pow_grad/Reshape_1-^gradients_1/loss_2/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_grad/Reshape_1
|
+gradients_1/loss_2/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_1/loss_2/Sum_3_grad/ReshapeReshape8gradients_1/loss_2/mul_2_grad/tuple/control_dependency_1+gradients_1/loss_2/Sum_3_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_1/loss_2/Sum_3_grad/ShapeShapeloss_2/pow_1*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_1/loss_2/Sum_3_grad/TileTile%gradients_1/loss_2/Sum_3_grad/Reshape#gradients_1/loss_2/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_1/loss_2/pow_2_grad/ShapeShapeloss_2/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_2_grad/Shape%gradients_1/loss_2/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_1/loss_2/pow_2_grad/mulMul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_1/loss_2/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_2_grad/subSubloss_2/pow_2/y#gradients_1/loss_2/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_2_grad/PowPowloss_2/pos_item_bias!gradients_1/loss_2/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_1/loss_2/pow_2_grad/mul_1Mul!gradients_1/loss_2/pow_2_grad/mul!gradients_1/loss_2/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_1/loss_2/pow_2_grad/SumSum#gradients_1/loss_2/pow_2_grad/mul_13gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/pow_2_grad/ReshapeReshape!gradients_1/loss_2/pow_2_grad/Sum#gradients_1/loss_2/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_1/loss_2/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_2_grad/GreaterGreaterloss_2/pos_item_bias'gradients_1/loss_2/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_1/loss_2/pow_2_grad/LogLogloss_2/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_1/loss_2/pow_2_grad/zeros_like	ZerosLikeloss_2/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_1/loss_2/pow_2_grad/SelectSelect%gradients_1/loss_2/pow_2_grad/Greater!gradients_1/loss_2/pow_2_grad/Log(gradients_1/loss_2/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_1/loss_2/pow_2_grad/mul_2Mul"gradients_1/loss_2/Sum_4_grad/Tileloss_2/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_1/loss_2/pow_2_grad/mul_3Mul#gradients_1/loss_2/pow_2_grad/mul_2$gradients_1/loss_2/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_1/loss_2/pow_2_grad/Sum_1Sum#gradients_1/loss_2/pow_2_grad/mul_35gradients_1/loss_2/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_2_grad/Reshape_1Reshape#gradients_1/loss_2/pow_2_grad/Sum_1%gradients_1/loss_2/pow_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/pow_2_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_2_grad/Reshape(^gradients_1/loss_2/pow_2_grad/Reshape_1
В
6gradients_1/loss_2/pow_2_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_2_grad/Reshape/^gradients_1/loss_2/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape
ы
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
%gradients_1/loss_2/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_3_grad/Shape%gradients_1/loss_2/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_1/loss_2/pow_3_grad/mulMul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_1/loss_2/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_3_grad/subSubloss_2/pow_3/y#gradients_1/loss_2/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_3_grad/PowPowloss_2/neg_items!gradients_1/loss_2/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_1/loss_2/pow_3_grad/mul_1Mul!gradients_1/loss_2/pow_3_grad/mul!gradients_1/loss_2/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_1/loss_2/pow_3_grad/SumSum#gradients_1/loss_2/pow_3_grad/mul_13gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_1/loss_2/pow_3_grad/ReshapeReshape!gradients_1/loss_2/pow_3_grad/Sum#gradients_1/loss_2/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_1/loss_2/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_3_grad/GreaterGreaterloss_2/neg_items'gradients_1/loss_2/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_1/loss_2/pow_3_grad/LogLogloss_2/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_1/loss_2/pow_3_grad/zeros_like	ZerosLikeloss_2/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_1/loss_2/pow_3_grad/SelectSelect%gradients_1/loss_2/pow_3_grad/Greater!gradients_1/loss_2/pow_3_grad/Log(gradients_1/loss_2/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_1/loss_2/pow_3_grad/mul_2Mul"gradients_1/loss_2/Sum_5_grad/Tileloss_2/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_1/loss_2/pow_3_grad/mul_3Mul#gradients_1/loss_2/pow_3_grad/mul_2$gradients_1/loss_2/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_1/loss_2/pow_3_grad/Sum_1Sum#gradients_1/loss_2/pow_3_grad/mul_35gradients_1/loss_2/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_3_grad/Reshape_1Reshape#gradients_1/loss_2/pow_3_grad/Sum_1%gradients_1/loss_2/pow_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/pow_3_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_3_grad/Reshape(^gradients_1/loss_2/pow_3_grad/Reshape_1
Ж
6gradients_1/loss_2/pow_3_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_3_grad/Reshape/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape
ы
8gradients_1/loss_2/pow_3_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_3_grad/Reshape_1/^gradients_1/loss_2/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_3_grad/Reshape_1
ј
+gradients_1/loss_2/Sigmoid_grad/SigmoidGradSigmoidGradloss_2/SigmoidFgradients_1/loss_2/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_1/loss_2/pow_1_grad/ShapeShapeloss_2/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_1/loss_2/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_1/loss_2/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/pow_1_grad/Shape%gradients_1/loss_2/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_1/loss_2/pow_1_grad/mulMul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_1/loss_2/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_1/loss_2/pow_1_grad/subSubloss_2/pow_1/y#gradients_1/loss_2/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_1/loss_2/pow_1_grad/PowPowloss_2/pos_items!gradients_1/loss_2/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_1/loss_2/pow_1_grad/mul_1Mul!gradients_1/loss_2/pow_1_grad/mul!gradients_1/loss_2/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_1/loss_2/pow_1_grad/SumSum#gradients_1/loss_2/pow_1_grad/mul_13gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_1/loss_2/pow_1_grad/ReshapeReshape!gradients_1/loss_2/pow_1_grad/Sum#gradients_1/loss_2/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_1/loss_2/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_1/loss_2/pow_1_grad/GreaterGreaterloss_2/pos_items'gradients_1/loss_2/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_1/loss_2/pow_1_grad/LogLogloss_2/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_1/loss_2/pow_1_grad/zeros_like	ZerosLikeloss_2/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_1/loss_2/pow_1_grad/SelectSelect%gradients_1/loss_2/pow_1_grad/Greater!gradients_1/loss_2/pow_1_grad/Log(gradients_1/loss_2/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_1/loss_2/pow_1_grad/mul_2Mul"gradients_1/loss_2/Sum_3_grad/Tileloss_2/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_1/loss_2/pow_1_grad/mul_3Mul#gradients_1/loss_2/pow_1_grad/mul_2$gradients_1/loss_2/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_1/loss_2/pow_1_grad/Sum_1Sum#gradients_1/loss_2/pow_1_grad/mul_35gradients_1/loss_2/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_1/loss_2/pow_1_grad/Reshape_1Reshape#gradients_1/loss_2/pow_1_grad/Sum_1%gradients_1/loss_2/pow_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_1/loss_2/pow_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/pow_1_grad/Reshape(^gradients_1/loss_2/pow_1_grad/Reshape_1
Ж
6gradients_1/loss_2/pow_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/pow_1_grad/Reshape/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape
ы
8gradients_1/loss_2/pow_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/pow_1_grad/Reshape_1/^gradients_1/loss_2/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_1/loss_2/pow_1_grad/Reshape_1
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
ѕ
1gradients_1/loss_2/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/add_grad/Shape#gradients_1/loss_2/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_1/loss_2/add_grad/SumSum+gradients_1/loss_2/Sigmoid_grad/SigmoidGrad1gradients_1/loss_2/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_1/loss_2/add_grad/ReshapeReshapegradients_1/loss_2/add_grad/Sum!gradients_1/loss_2/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
!gradients_1/loss_2/add_grad/Sum_1Sum+gradients_1/loss_2/Sigmoid_grad/SigmoidGrad3gradients_1/loss_2/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/add_grad/Reshape_1Reshape!gradients_1/loss_2/add_grad/Sum_1#gradients_1/loss_2/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
В
,gradients_1/loss_2/add_grad/tuple/group_depsNoOp$^gradients_1/loss_2/add_grad/Reshape&^gradients_1/loss_2/add_grad/Reshape_1
ъ
4gradients_1/loss_2/add_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/add_grad/Reshape-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_1/loss_2/add_grad/Reshape
А
6gradients_1/loss_2/add_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/add_grad/Reshape_1-^gradients_1/loss_2/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
’
3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_1/loss_2/sub_1_grad/Shape%gradients_1/loss_2/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_1/loss_2/sub_1_grad/SumSum4gradients_1/loss_2/add_grad/tuple/control_dependency3gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_1/loss_2/sub_1_grad/ReshapeReshape!gradients_1/loss_2/sub_1_grad/Sum#gradients_1/loss_2/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
„
#gradients_1/loss_2/sub_1_grad/Sum_1Sum4gradients_1/loss_2/add_grad/tuple/control_dependency5gradients_1/loss_2/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_1/loss_2/sub_1_grad/NegNeg#gradients_1/loss_2/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_1/loss_2/sub_1_grad/Reshape_1Reshape!gradients_1/loss_2/sub_1_grad/Neg%gradients_1/loss_2/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
И
.gradients_1/loss_2/sub_1_grad/tuple/group_depsNoOp&^gradients_1/loss_2/sub_1_grad/Reshape(^gradients_1/loss_2/sub_1_grad/Reshape_1
В
6gradients_1/loss_2/sub_1_grad/tuple/control_dependencyIdentity%gradients_1/loss_2/sub_1_grad/Reshape/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_1_grad/Reshape
И
8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1Identity'gradients_1/loss_2/sub_1_grad/Reshape_1/^gradients_1/loss_2/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
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
 gradients_1/loss_2/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_1/loss_2/Sum_grad/addAddloss_2/Sum/reduction_indices gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_1/loss_2/Sum_grad/modFloorModgradients_1/loss_2/Sum_grad/add gradients_1/loss_2/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_1/loss_2/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_1/loss_2/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_1/loss_2/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_1/loss_2/Sum_grad/rangeRange'gradients_1/loss_2/Sum_grad/range/start gradients_1/loss_2/Sum_grad/Size'gradients_1/loss_2/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_1/loss_2/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_1/loss_2/Sum_grad/FillFill#gradients_1/loss_2/Sum_grad/Shape_1&gradients_1/loss_2/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_1/loss_2/Sum_grad/DynamicStitchDynamicStitch!gradients_1/loss_2/Sum_grad/rangegradients_1/loss_2/Sum_grad/mod!gradients_1/loss_2/Sum_grad/Shape gradients_1/loss_2/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
T0*
N
g
%gradients_1/loss_2/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_1/loss_2/Sum_grad/MaximumMaximum)gradients_1/loss_2/Sum_grad/DynamicStitch%gradients_1/loss_2/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_1/loss_2/Sum_grad/floordivFloorDiv!gradients_1/loss_2/Sum_grad/Shape#gradients_1/loss_2/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_1/loss_2/Sum_grad/ReshapeReshape6gradients_1/loss_2/add_grad/tuple/control_dependency_1)gradients_1/loss_2/Sum_grad/DynamicStitch*
_output_shapes
:*
Tshape0*
T0
Ј
 gradients_1/loss_2/Sum_grad/TileTile#gradients_1/loss_2/Sum_grad/Reshape$gradients_1/loss_2/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_1/AddNAddN6gradients_1/loss_2/pow_2_grad/tuple/control_dependency6gradients_1/loss_2/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_2_grad/Reshape
†
+gradients_1/loss_2/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_1/item_bias
Е
*gradients_1/loss_2/pos_item_bias_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_1/loss_2/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/pos_item_bias_grad/Size4gradients_1/loss_2/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_1/loss_2/pos_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/pos_item_bias_grad/Shape9gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_1/loss_2/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_1/loss_2/pos_item_bias_grad/concatConcatV20gradients_1/loss_2/pos_item_bias_grad/ExpandDims3gradients_1/loss_2/pos_item_bias_grad/strided_slice1gradients_1/loss_2/pos_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
і
-gradients_1/loss_2/pos_item_bias_grad/ReshapeReshapegradients_1/AddN,gradients_1/loss_2/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_1/loss_2/pos_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_pos_items0gradients_1/loss_2/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
э
gradients_1/AddN_1AddN6gradients_1/loss_2/pow_4_grad/tuple/control_dependency8gradients_1/loss_2/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_4_grad/Reshape
†
+gradients_1/loss_2/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_1/item_bias
Е
*gradients_1/loss_2/neg_item_bias_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_1/loss_2/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_1/loss_2/neg_item_bias_grad/Size4gradients_1/loss_2/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_1/loss_2/neg_item_bias_grad/strided_sliceStridedSlice+gradients_1/loss_2/neg_item_bias_grad/Shape9gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_1;gradients_1/loss_2/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_1/loss_2/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_1/loss_2/neg_item_bias_grad/concatConcatV20gradients_1/loss_2/neg_item_bias_grad/ExpandDims3gradients_1/loss_2/neg_item_bias_grad/strided_slice1gradients_1/loss_2/neg_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ґ
-gradients_1/loss_2/neg_item_bias_grad/ReshapeReshapegradients_1/AddN_1,gradients_1/loss_2/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_1/loss_2/neg_item_bias_grad/Reshape_1Reshape placeholders_1/sampled_neg_items0gradients_1/loss_2/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
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
ѕ
1gradients_1/loss_2/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/mul_grad/Shape#gradients_1/loss_2/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_1/loss_2/mul_grad/mulMul gradients_1/loss_2/Sum_grad/Tile
loss_2/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_1/loss_2/mul_grad/SumSumgradients_1/loss_2/mul_grad/mul1gradients_1/loss_2/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_1/loss_2/mul_grad/ReshapeReshapegradients_1/loss_2/mul_grad/Sum!gradients_1/loss_2/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
К
!gradients_1/loss_2/mul_grad/mul_1Mulloss_2/users gradients_1/loss_2/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_1/loss_2/mul_grad/Sum_1Sum!gradients_1/loss_2/mul_grad/mul_13gradients_1/loss_2/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_1/loss_2/mul_grad/Reshape_1Reshape!gradients_1/loss_2/mul_grad/Sum_1#gradients_1/loss_2/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_1/loss_2/mul_grad/tuple/group_depsNoOp$^gradients_1/loss_2/mul_grad/Reshape&^gradients_1/loss_2/mul_grad/Reshape_1
ю
4gradients_1/loss_2/mul_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/mul_grad/Reshape-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_1/loss_2/mul_grad/Reshape
Д
6gradients_1/loss_2/mul_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/mul_grad/Reshape_1-^gradients_1/loss_2/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/mul_grad/Reshape_1
Y
gradients_1/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_1/concatConcatV2-gradients_1/loss_2/pos_item_bias_grad/Reshape-gradients_1/loss_2/neg_item_bias_grad/Reshapegradients_1/concat/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_1/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_1/concat_1ConcatV2/gradients_1/loss_2/pos_item_bias_grad/Reshape_1/gradients_1/loss_2/neg_item_bias_grad/Reshape_1gradients_1/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
щ
gradients_1/AddN_2AddN4gradients_1/loss_2/pow_grad/tuple/control_dependency4gradients_1/loss_2/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*6
_class,
*(loc:@gradients_1/loss_2/pow_grad/Reshape
°
#gradients_1/loss_2/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_1/user_factors
y
"gradients_1/loss_2/users_grad/SizeSizeplaceholders_1/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_1/loss_2/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_1/loss_2/users_grad/ExpandDims
ExpandDims"gradients_1/loss_2/users_grad/Size,gradients_1/loss_2/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_1/loss_2/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_1/loss_2/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_1/loss_2/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_1/loss_2/users_grad/strided_sliceStridedSlice#gradients_1/loss_2/users_grad/Shape1gradients_1/loss_2/users_grad/strided_slice/stack3gradients_1/loss_2/users_grad/strided_slice/stack_13gradients_1/loss_2/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_1/loss_2/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_1/loss_2/users_grad/concatConcatV2(gradients_1/loss_2/users_grad/ExpandDims+gradients_1/loss_2/users_grad/strided_slice)gradients_1/loss_2/users_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
≥
%gradients_1/loss_2/users_grad/ReshapeReshapegradients_1/AddN_2$gradients_1/loss_2/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
ґ
'gradients_1/loss_2/users_grad/Reshape_1Reshapeplaceholders_1/sampled_users(gradients_1/loss_2/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
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
ѕ
1gradients_1/loss_2/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_1/loss_2/sub_grad/Shape#gradients_1/loss_2/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_1/loss_2/sub_grad/SumSum6gradients_1/loss_2/mul_grad/tuple/control_dependency_11gradients_1/loss_2/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_1/loss_2/sub_grad/ReshapeReshapegradients_1/loss_2/sub_grad/Sum!gradients_1/loss_2/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
’
!gradients_1/loss_2/sub_grad/Sum_1Sum6gradients_1/loss_2/mul_grad/tuple/control_dependency_13gradients_1/loss_2/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_1/loss_2/sub_grad/NegNeg!gradients_1/loss_2/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_1/loss_2/sub_grad/Reshape_1Reshapegradients_1/loss_2/sub_grad/Neg#gradients_1/loss_2/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_1/loss_2/sub_grad/tuple/group_depsNoOp$^gradients_1/loss_2/sub_grad/Reshape&^gradients_1/loss_2/sub_grad/Reshape_1
ю
4gradients_1/loss_2/sub_grad/tuple/control_dependencyIdentity#gradients_1/loss_2/sub_grad/Reshape-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_1/loss_2/sub_grad/Reshape
Д
6gradients_1/loss_2/sub_grad/tuple/control_dependency_1Identity%gradients_1/loss_2/sub_grad/Reshape_1-^gradients_1/loss_2/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_1/loss_2/sub_grad/Reshape_1
э
gradients_1/AddN_3AddN6gradients_1/loss_2/pow_1_grad/tuple/control_dependency4gradients_1/loss_2/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_1_grad/Reshape
•
'gradients_1/loss_2/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_1/item_factors
Б
&gradients_1/loss_2/pos_items_grad/SizeSize placeholders_1/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_1/loss_2/pos_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/pos_items_grad/Size0gradients_1/loss_2/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_1/loss_2/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_1/loss_2/pos_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/pos_items_grad/Shape5gradients_1/loss_2/pos_items_grad/strided_slice/stack7gradients_1/loss_2/pos_items_grad/strided_slice/stack_17gradients_1/loss_2/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_1/loss_2/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_1/loss_2/pos_items_grad/concatConcatV2,gradients_1/loss_2/pos_items_grad/ExpandDims/gradients_1/loss_2/pos_items_grad/strided_slice-gradients_1/loss_2/pos_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_1/loss_2/pos_items_grad/ReshapeReshapegradients_1/AddN_3(gradients_1/loss_2/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_1/loss_2/pos_items_grad/Reshape_1Reshape placeholders_1/sampled_pos_items,gradients_1/loss_2/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
€
gradients_1/AddN_4AddN6gradients_1/loss_2/pow_3_grad/tuple/control_dependency6gradients_1/loss_2/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_1/loss_2/pow_3_grad/Reshape
•
'gradients_1/loss_2/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_1/item_factors
Б
&gradients_1/loss_2/neg_items_grad/SizeSize placeholders_1/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_1/loss_2/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_1/loss_2/neg_items_grad/ExpandDims
ExpandDims&gradients_1/loss_2/neg_items_grad/Size0gradients_1/loss_2/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_1/loss_2/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_1/loss_2/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_1/loss_2/neg_items_grad/strided_sliceStridedSlice'gradients_1/loss_2/neg_items_grad/Shape5gradients_1/loss_2/neg_items_grad/strided_slice/stack7gradients_1/loss_2/neg_items_grad/strided_slice/stack_17gradients_1/loss_2/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_1/loss_2/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_1/loss_2/neg_items_grad/concatConcatV2,gradients_1/loss_2/neg_items_grad/ExpandDims/gradients_1/loss_2/neg_items_grad/strided_slice-gradients_1/loss_2/neg_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_1/loss_2/neg_items_grad/ReshapeReshapegradients_1/AddN_4(gradients_1/loss_2/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_1/loss_2/neg_items_grad/Reshape_1Reshape placeholders_1/sampled_neg_items,gradients_1/loss_2/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
[
gradients_1/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_1/concat_2ConcatV2)gradients_1/loss_2/pos_items_grad/Reshape)gradients_1/loss_2/neg_items_grad/Reshapegradients_1/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_1/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_1/concat_3ConcatV2+gradients_1/loss_2/pos_items_grad/Reshape_1+gradients_1/loss_2/neg_items_grad/Reshape_1gradients_1/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
d
GradientDescent_1/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_1/update_variables_1/user_factors/mulMul%gradients_1/loss_2/users_grad/ReshapeGradientDescent_1/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_1/user_factors
Њ
<GradientDescent_1/update_variables_1/user_factors/ScatterSub
ScatterSubvariables_1/user_factors'gradients_1/loss_2/users_grad/Reshape_15GradientDescent_1/update_variables_1/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_1/user_factors
џ
5GradientDescent_1/update_variables_1/item_factors/mulMulgradients_1/concat_2GradientDescent_1/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_1/item_factors
Ђ
<GradientDescent_1/update_variables_1/item_factors/ScatterSub
ScatterSubvariables_1/item_factorsgradients_1/concat_35GradientDescent_1/update_variables_1/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_1/item_factors
∆
2GradientDescent_1/update_variables_1/item_bias/mulMulgradients_1/concatGradientDescent_1/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_1/item_bias
Ы
9GradientDescent_1/update_variables_1/item_bias/ScatterSub
ScatterSubvariables_1/item_biasgradients_1/concat_12GradientDescent_1/update_variables_1/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_1/item_bias
”
GradientDescent_1NoOp=^GradientDescent_1/update_variables_1/user_factors/ScatterSub=^GradientDescent_1/update_variables_1/item_factors/ScatterSub:^GradientDescent_1/update_variables_1/item_bias/ScatterSub
R
loss_3/tagsConst*
valueB Bloss_3*
_output_shapes
: *
dtype0
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
ќ
init_1NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign
j
placeholders_2/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_2/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_2/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_2/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_2/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_2/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_2/truncated_normal/TruncatedNormalTruncatedNormal"variables_2/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_2/truncated_normal/mulMul,variables_2/truncated_normal/TruncatedNormal#variables_2/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_2/truncated_normalAdd variables_2/truncated_normal/mul!variables_2/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_2/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_2/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_2/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_2/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_2/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_2/truncated_normal_1/mulMul.variables_2/truncated_normal_1/TruncatedNormal%variables_2/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_2/truncated_normal_1Add"variables_2/truncated_normal_1/mul#variables_2/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_2/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_2/user_factors/AssignAssignvariables_2/user_factorsvariables_2/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_2/user_factors
Ъ
variables_2/user_factors/readIdentityvariables_2/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_2/user_factors
О
variables_2/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_2/item_factors/AssignAssignvariables_2/item_factorsvariables_2/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_2/item_factors
Ъ
variables_2/item_factors/readIdentityvariables_2/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_2/item_factors
`
variables_2/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_2/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_2/item_bias/AssignAssignvariables_2/item_biasvariables_2/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_2/item_bias
Н
variables_2/item_bias/readIdentityvariables_2/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_2/item_bias
≥
loss_4/usersGathervariables_2/user_factors/readplaceholders_2/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_4/pos_itemsGathervariables_2/item_factors/read placeholders_2/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_4/neg_itemsGathervariables_2/item_factors/read placeholders_2/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_4/pos_item_biasGathervariables_2/item_bias/read placeholders_2/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_4/neg_item_biasGathervariables_2/item_bias/read placeholders_2/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_4/subSubloss_4/pos_itemsloss_4/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_4/mulMulloss_4/users
loss_4/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_4/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_4/SumSum
loss_4/mulloss_4/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_4/sub_1Subloss_4/pos_item_biasloss_4/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_4/addAddloss_4/sub_1
loss_4/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_4/SigmoidSigmoid
loss_4/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_4/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_4/clip_by_value/MinimumMinimumloss_4/Sigmoidloss_4/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_4/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_4/clip_by_valueMaximumloss_4/clip_by_value/Minimumloss_4/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_4/LogLogloss_4/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_4/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_4/Sum_1Sum
loss_4/Logloss_4/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_4/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_4/powPowloss_4/usersloss_4/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_4/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_4/Sum_2Sum
loss_4/powloss_4/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_4/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_4/mul_1Mulloss_4/mul_1/xloss_4/Sum_2*
_output_shapes
: *
T0
S
loss_4/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_1Powloss_4/pos_itemsloss_4/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_4/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_4/Sum_3Sumloss_4/pow_1loss_4/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_4/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_4/mul_2Mulloss_4/mul_2/xloss_4/Sum_3*
_output_shapes
: *
T0
S
loss_4/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_2Powloss_4/pos_item_biasloss_4/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_4/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_4/Sum_4Sumloss_4/pow_2loss_4/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_4/add_1Addloss_4/mul_2loss_4/Sum_4*
_output_shapes
: *
T0
S
loss_4/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_3Powloss_4/neg_itemsloss_4/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_4/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_4/Sum_5Sumloss_4/pow_3loss_4/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_4/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_4/mul_3Mulloss_4/mul_3/xloss_4/Sum_5*
_output_shapes
: *
T0
S
loss_4/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_4/pow_4Powloss_4/neg_item_biasloss_4/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_4/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_4/Sum_6Sumloss_4/pow_4loss_4/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_4/add_2Addloss_4/mul_3loss_4/Sum_6*
_output_shapes
: *
T0
P
loss_4/add_3Addloss_4/mul_1loss_4/add_1*
_output_shapes
: *
T0
P
loss_4/add_4Addloss_4/add_3loss_4/add_2*
_output_shapes
: *
T0
P
loss_4/sub_2Subloss_4/add_4loss_4/Sum_1*
_output_shapes
: *
T0
T
gradients_2/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_2/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_2/FillFillgradients_2/Shapegradients_2/Const*
_output_shapes
: *
T0
f
#gradients_2/loss_4/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/sub_2_grad/Shape%gradients_2/loss_4/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_2/loss_4/sub_2_grad/SumSumgradients_2/Fill3gradients_2/loss_4/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/sub_2_grad/ReshapeReshape!gradients_2/loss_4/sub_2_grad/Sum#gradients_2/loss_4/sub_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
≥
#gradients_2/loss_4/sub_2_grad/Sum_1Sumgradients_2/Fill5gradients_2/loss_4/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_2/loss_4/sub_2_grad/NegNeg#gradients_2/loss_4/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_2/loss_4/sub_2_grad/Reshape_1Reshape!gradients_2/loss_4/sub_2_grad/Neg%gradients_2/loss_4/sub_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/sub_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/sub_2_grad/Reshape(^gradients_2/loss_4/sub_2_grad/Reshape_1
х
6gradients_2/loss_4/sub_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/sub_2_grad/Reshape/^gradients_2/loss_4/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/sub_2_grad/Reshape
ы
8gradients_2/loss_4/sub_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/sub_2_grad/Reshape_1/^gradients_2/loss_4/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/sub_2_grad/Reshape_1
f
#gradients_2/loss_4/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_4_grad/Shape%gradients_2/loss_4/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_2/loss_4/add_4_grad/SumSum6gradients_2/loss_4/sub_2_grad/tuple/control_dependency3gradients_2/loss_4/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_4_grad/ReshapeReshape!gradients_2/loss_4/add_4_grad/Sum#gradients_2/loss_4/add_4_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_2/loss_4/add_4_grad/Sum_1Sum6gradients_2/loss_4/sub_2_grad/tuple/control_dependency5gradients_2/loss_4/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_4_grad/Reshape_1Reshape#gradients_2/loss_4/add_4_grad/Sum_1%gradients_2/loss_4/add_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/add_4_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_4_grad/Reshape(^gradients_2/loss_4/add_4_grad/Reshape_1
х
6gradients_2/loss_4/add_4_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_4_grad/Reshape/^gradients_2/loss_4/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_4_grad/Reshape
ы
8gradients_2/loss_4/add_4_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_4_grad/Reshape_1/^gradients_2/loss_4/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_4_grad/Reshape_1
u
+gradients_2/loss_4/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_2/loss_4/Sum_1_grad/ReshapeReshape8gradients_2/loss_4/sub_2_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_1_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
m
#gradients_2/loss_4/Sum_1_grad/ShapeShape
loss_4/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_2/loss_4/Sum_1_grad/TileTile%gradients_2/loss_4/Sum_1_grad/Reshape#gradients_2/loss_4/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_2/loss_4/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_3_grad/Shape%gradients_2/loss_4/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_2/loss_4/add_3_grad/SumSum6gradients_2/loss_4/add_4_grad/tuple/control_dependency3gradients_2/loss_4/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_3_grad/ReshapeReshape!gradients_2/loss_4/add_3_grad/Sum#gradients_2/loss_4/add_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_2/loss_4/add_3_grad/Sum_1Sum6gradients_2/loss_4/add_4_grad/tuple/control_dependency5gradients_2/loss_4/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_3_grad/Reshape_1Reshape#gradients_2/loss_4/add_3_grad/Sum_1%gradients_2/loss_4/add_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/add_3_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_3_grad/Reshape(^gradients_2/loss_4/add_3_grad/Reshape_1
х
6gradients_2/loss_4/add_3_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_3_grad/Reshape/^gradients_2/loss_4/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_3_grad/Reshape
ы
8gradients_2/loss_4/add_3_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_3_grad/Reshape_1/^gradients_2/loss_4/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_3_grad/Reshape_1
f
#gradients_2/loss_4/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_2_grad/Shape%gradients_2/loss_4/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_2/loss_4/add_2_grad/SumSum8gradients_2/loss_4/add_4_grad/tuple/control_dependency_13gradients_2/loss_4/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_2_grad/ReshapeReshape!gradients_2/loss_4/add_2_grad/Sum#gradients_2/loss_4/add_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_2/loss_4/add_2_grad/Sum_1Sum8gradients_2/loss_4/add_4_grad/tuple/control_dependency_15gradients_2/loss_4/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_2_grad/Reshape_1Reshape#gradients_2/loss_4/add_2_grad/Sum_1%gradients_2/loss_4/add_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/add_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_2_grad/Reshape(^gradients_2/loss_4/add_2_grad/Reshape_1
х
6gradients_2/loss_4/add_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_2_grad/Reshape/^gradients_2/loss_4/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_2_grad/Reshape
ы
8gradients_2/loss_4/add_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_2_grad/Reshape_1/^gradients_2/loss_4/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_2_grad/Reshape_1
Э
&gradients_2/loss_4/Log_grad/Reciprocal
Reciprocalloss_4/clip_by_value#^gradients_2/loss_4/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_2/loss_4/Log_grad/mulMul"gradients_2/loss_4/Sum_1_grad/Tile&gradients_2/loss_4/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_2/loss_4/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/mul_1_grad/Shape%gradients_2/loss_4/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_2/loss_4/mul_1_grad/mulMul6gradients_2/loss_4/add_3_grad/tuple/control_dependencyloss_4/Sum_2*
_output_shapes
: *
T0
ј
!gradients_2/loss_4/mul_1_grad/SumSum!gradients_2/loss_4/mul_1_grad/mul3gradients_2/loss_4/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/mul_1_grad/ReshapeReshape!gradients_2/loss_4/mul_1_grad/Sum#gradients_2/loss_4/mul_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_2/loss_4/mul_1_grad/mul_1Mulloss_4/mul_1/x6gradients_2/loss_4/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_2/loss_4/mul_1_grad/Sum_1Sum#gradients_2/loss_4/mul_1_grad/mul_15gradients_2/loss_4/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/mul_1_grad/Reshape_1Reshape#gradients_2/loss_4/mul_1_grad/Sum_1%gradients_2/loss_4/mul_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/mul_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/mul_1_grad/Reshape(^gradients_2/loss_4/mul_1_grad/Reshape_1
х
6gradients_2/loss_4/mul_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/mul_1_grad/Reshape/^gradients_2/loss_4/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_1_grad/Reshape
ы
8gradients_2/loss_4/mul_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/mul_1_grad/Reshape_1/^gradients_2/loss_4/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/mul_1_grad/Reshape_1
f
#gradients_2/loss_4/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/add_1_grad/Shape%gradients_2/loss_4/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_2/loss_4/add_1_grad/SumSum8gradients_2/loss_4/add_3_grad/tuple/control_dependency_13gradients_2/loss_4/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/add_1_grad/ReshapeReshape!gradients_2/loss_4/add_1_grad/Sum#gradients_2/loss_4/add_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_2/loss_4/add_1_grad/Sum_1Sum8gradients_2/loss_4/add_3_grad/tuple/control_dependency_15gradients_2/loss_4/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/add_1_grad/Reshape_1Reshape#gradients_2/loss_4/add_1_grad/Sum_1%gradients_2/loss_4/add_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/add_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/add_1_grad/Reshape(^gradients_2/loss_4/add_1_grad/Reshape_1
х
6gradients_2/loss_4/add_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/add_1_grad/Reshape/^gradients_2/loss_4/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/add_1_grad/Reshape
ы
8gradients_2/loss_4/add_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/add_1_grad/Reshape_1/^gradients_2/loss_4/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/add_1_grad/Reshape_1
f
#gradients_2/loss_4/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/mul_3_grad/Shape%gradients_2/loss_4/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_2/loss_4/mul_3_grad/mulMul6gradients_2/loss_4/add_2_grad/tuple/control_dependencyloss_4/Sum_5*
_output_shapes
: *
T0
ј
!gradients_2/loss_4/mul_3_grad/SumSum!gradients_2/loss_4/mul_3_grad/mul3gradients_2/loss_4/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/mul_3_grad/ReshapeReshape!gradients_2/loss_4/mul_3_grad/Sum#gradients_2/loss_4/mul_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_2/loss_4/mul_3_grad/mul_1Mulloss_4/mul_3/x6gradients_2/loss_4/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_2/loss_4/mul_3_grad/Sum_1Sum#gradients_2/loss_4/mul_3_grad/mul_15gradients_2/loss_4/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/mul_3_grad/Reshape_1Reshape#gradients_2/loss_4/mul_3_grad/Sum_1%gradients_2/loss_4/mul_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/mul_3_grad/tuple/group_depsNoOp&^gradients_2/loss_4/mul_3_grad/Reshape(^gradients_2/loss_4/mul_3_grad/Reshape_1
х
6gradients_2/loss_4/mul_3_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/mul_3_grad/Reshape/^gradients_2/loss_4/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_3_grad/Reshape
ы
8gradients_2/loss_4/mul_3_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/mul_3_grad/Reshape_1/^gradients_2/loss_4/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/mul_3_grad/Reshape_1
u
+gradients_2/loss_4/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_2/loss_4/Sum_6_grad/ReshapeReshape8gradients_2/loss_4/add_2_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_6_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_2/loss_4/Sum_6_grad/ShapeShapeloss_4/pow_4*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_2/loss_4/Sum_6_grad/TileTile%gradients_2/loss_4/Sum_6_grad/Reshape#gradients_2/loss_4/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_2/loss_4/clip_by_value_grad/ShapeShapeloss_4/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_2/loss_4/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_2/loss_4/clip_by_value_grad/Shape_2Shapegradients_2/loss_4/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_2/loss_4/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_2/loss_4/clip_by_value_grad/zerosFill-gradients_2/loss_4/clip_by_value_grad/Shape_21gradients_2/loss_4/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_2/loss_4/clip_by_value_grad/GreaterEqualGreaterEqualloss_4/clip_by_value/Minimumloss_4/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_2/loss_4/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_2/loss_4/clip_by_value_grad/Shape-gradients_2/loss_4/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_2/loss_4/clip_by_value_grad/SelectSelect2gradients_2/loss_4/clip_by_value_grad/GreaterEqualgradients_2/loss_4/Log_grad/mul+gradients_2/loss_4/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_2/loss_4/clip_by_value_grad/LogicalNot
LogicalNot2gradients_2/loss_4/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_2/loss_4/clip_by_value_grad/Select_1Select0gradients_2/loss_4/clip_by_value_grad/LogicalNotgradients_2/loss_4/Log_grad/mul+gradients_2/loss_4/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_2/loss_4/clip_by_value_grad/SumSum,gradients_2/loss_4/clip_by_value_grad/Select;gradients_2/loss_4/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_2/loss_4/clip_by_value_grad/ReshapeReshape)gradients_2/loss_4/clip_by_value_grad/Sum+gradients_2/loss_4/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
б
+gradients_2/loss_4/clip_by_value_grad/Sum_1Sum.gradients_2/loss_4/clip_by_value_grad/Select_1=gradients_2/loss_4/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_2/loss_4/clip_by_value_grad/Reshape_1Reshape+gradients_2/loss_4/clip_by_value_grad/Sum_1-gradients_2/loss_4/clip_by_value_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
†
6gradients_2/loss_4/clip_by_value_grad/tuple/group_depsNoOp.^gradients_2/loss_4/clip_by_value_grad/Reshape0^gradients_2/loss_4/clip_by_value_grad/Reshape_1
Ґ
>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_2/loss_4/clip_by_value_grad/Reshape7^gradients_2/loss_4/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_2/loss_4/clip_by_value_grad/Reshape
Ы
@gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_2/loss_4/clip_by_value_grad/Reshape_17^gradients_2/loss_4/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_2/loss_4/clip_by_value_grad/Reshape_1
|
+gradients_2/loss_4/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_2/loss_4/Sum_2_grad/ReshapeReshape8gradients_2/loss_4/mul_1_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_2_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
m
#gradients_2/loss_4/Sum_2_grad/ShapeShape
loss_4/pow*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_2/loss_4/Sum_2_grad/TileTile%gradients_2/loss_4/Sum_2_grad/Reshape#gradients_2/loss_4/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_2/loss_4/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_2/loss_4/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/mul_2_grad/Shape%gradients_2/loss_4/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_2/loss_4/mul_2_grad/mulMul6gradients_2/loss_4/add_1_grad/tuple/control_dependencyloss_4/Sum_3*
_output_shapes
: *
T0
ј
!gradients_2/loss_4/mul_2_grad/SumSum!gradients_2/loss_4/mul_2_grad/mul3gradients_2/loss_4/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/mul_2_grad/ReshapeReshape!gradients_2/loss_4/mul_2_grad/Sum#gradients_2/loss_4/mul_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_2/loss_4/mul_2_grad/mul_1Mulloss_4/mul_2/x6gradients_2/loss_4/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_2/loss_4/mul_2_grad/Sum_1Sum#gradients_2/loss_4/mul_2_grad/mul_15gradients_2/loss_4/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/mul_2_grad/Reshape_1Reshape#gradients_2/loss_4/mul_2_grad/Sum_1%gradients_2/loss_4/mul_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/mul_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/mul_2_grad/Reshape(^gradients_2/loss_4/mul_2_grad/Reshape_1
х
6gradients_2/loss_4/mul_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/mul_2_grad/Reshape/^gradients_2/loss_4/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_2_grad/Reshape
ы
8gradients_2/loss_4/mul_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/mul_2_grad/Reshape_1/^gradients_2/loss_4/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/mul_2_grad/Reshape_1
u
+gradients_2/loss_4/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_2/loss_4/Sum_4_grad/ReshapeReshape8gradients_2/loss_4/add_1_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_4_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_2/loss_4/Sum_4_grad/ShapeShapeloss_4/pow_2*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_2/loss_4/Sum_4_grad/TileTile%gradients_2/loss_4/Sum_4_grad/Reshape#gradients_2/loss_4/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_2/loss_4/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_2/loss_4/Sum_5_grad/ReshapeReshape8gradients_2/loss_4/mul_3_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_5_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_2/loss_4/Sum_5_grad/ShapeShapeloss_4/pow_3*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_2/loss_4/Sum_5_grad/TileTile%gradients_2/loss_4/Sum_5_grad/Reshape#gradients_2/loss_4/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_2/loss_4/pow_4_grad/ShapeShapeloss_4/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_4_grad/Shape%gradients_2/loss_4/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_2/loss_4/pow_4_grad/mulMul"gradients_2/loss_4/Sum_6_grad/Tileloss_4/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_2/loss_4/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_4_grad/subSubloss_4/pow_4/y#gradients_2/loss_4/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_4_grad/PowPowloss_4/neg_item_bias!gradients_2/loss_4/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_2/loss_4/pow_4_grad/mul_1Mul!gradients_2/loss_4/pow_4_grad/mul!gradients_2/loss_4/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_2/loss_4/pow_4_grad/SumSum#gradients_2/loss_4/pow_4_grad/mul_13gradients_2/loss_4/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/pow_4_grad/ReshapeReshape!gradients_2/loss_4/pow_4_grad/Sum#gradients_2/loss_4/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_2/loss_4/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_4_grad/GreaterGreaterloss_4/neg_item_bias'gradients_2/loss_4/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_2/loss_4/pow_4_grad/LogLogloss_4/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_2/loss_4/pow_4_grad/zeros_like	ZerosLikeloss_4/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_2/loss_4/pow_4_grad/SelectSelect%gradients_2/loss_4/pow_4_grad/Greater!gradients_2/loss_4/pow_4_grad/Log(gradients_2/loss_4/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_2/loss_4/pow_4_grad/mul_2Mul"gradients_2/loss_4/Sum_6_grad/Tileloss_4/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_2/loss_4/pow_4_grad/mul_3Mul#gradients_2/loss_4/pow_4_grad/mul_2$gradients_2/loss_4/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_2/loss_4/pow_4_grad/Sum_1Sum#gradients_2/loss_4/pow_4_grad/mul_35gradients_2/loss_4/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_4_grad/Reshape_1Reshape#gradients_2/loss_4/pow_4_grad/Sum_1%gradients_2/loss_4/pow_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/pow_4_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_4_grad/Reshape(^gradients_2/loss_4/pow_4_grad/Reshape_1
В
6gradients_2/loss_4/pow_4_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_4_grad/Reshape/^gradients_2/loss_4/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_4_grad/Reshape
ы
8gradients_2/loss_4/pow_4_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_4_grad/Reshape_1/^gradients_2/loss_4/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_4_grad/Reshape_1
Б
3gradients_2/loss_4/clip_by_value/Minimum_grad/ShapeShapeloss_4/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_2Shape>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_2/loss_4/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_2/loss_4/clip_by_value/Minimum_grad/zerosFill5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_29gradients_2/loss_4/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_2/loss_4/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_4/Sigmoidloss_4/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_2/loss_4/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_2/loss_4/clip_by_value/Minimum_grad/Shape5gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_2/loss_4/clip_by_value/Minimum_grad/SelectSelect7gradients_2/loss_4/clip_by_value/Minimum_grad/LessEqual>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency3gradients_2/loss_4/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_2/loss_4/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_2/loss_4/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_2/loss_4/clip_by_value/Minimum_grad/Select_1Select8gradients_2/loss_4/clip_by_value/Minimum_grad/LogicalNot>gradients_2/loss_4/clip_by_value_grad/tuple/control_dependency3gradients_2/loss_4/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_2/loss_4/clip_by_value/Minimum_grad/SumSum4gradients_2/loss_4/clip_by_value/Minimum_grad/SelectCgradients_2/loss_4/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_2/loss_4/clip_by_value/Minimum_grad/ReshapeReshape1gradients_2/loss_4/clip_by_value/Minimum_grad/Sum3gradients_2/loss_4/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
щ
3gradients_2/loss_4/clip_by_value/Minimum_grad/Sum_1Sum6gradients_2/loss_4/clip_by_value/Minimum_grad/Select_1Egradients_2/loss_4/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_2/loss_4/clip_by_value/Minimum_grad/Sum_15gradients_2/loss_4/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
Є
>gradients_2/loss_4/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape8^gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_2/loss_4/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape?^gradients_2/loss_4/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_2/loss_4/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1?^gradients_2/loss_4/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_2/loss_4/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_2/loss_4/pow_grad/ShapeShapeloss_4/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_2/loss_4/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_2/loss_4/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/pow_grad/Shape#gradients_2/loss_4/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_2/loss_4/pow_grad/mulMul"gradients_2/loss_4/Sum_2_grad/Tileloss_4/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_2/loss_4/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_2/loss_4/pow_grad/subSubloss_4/pow/y!gradients_2/loss_4/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_2/loss_4/pow_grad/PowPowloss_4/usersgradients_2/loss_4/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_2/loss_4/pow_grad/mul_1Mulgradients_2/loss_4/pow_grad/mulgradients_2/loss_4/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_2/loss_4/pow_grad/SumSum!gradients_2/loss_4/pow_grad/mul_11gradients_2/loss_4/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_2/loss_4/pow_grad/ReshapeReshapegradients_2/loss_4/pow_grad/Sum!gradients_2/loss_4/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
j
%gradients_2/loss_4/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_2/loss_4/pow_grad/GreaterGreaterloss_4/users%gradients_2/loss_4/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_2/loss_4/pow_grad/LogLogloss_4/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_2/loss_4/pow_grad/zeros_like	ZerosLikeloss_4/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_2/loss_4/pow_grad/SelectSelect#gradients_2/loss_4/pow_grad/Greatergradients_2/loss_4/pow_grad/Log&gradients_2/loss_4/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_2/loss_4/pow_grad/mul_2Mul"gradients_2/loss_4/Sum_2_grad/Tile
loss_4/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_2/loss_4/pow_grad/mul_3Mul!gradients_2/loss_4/pow_grad/mul_2"gradients_2/loss_4/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_2/loss_4/pow_grad/Sum_1Sum!gradients_2/loss_4/pow_grad/mul_33gradients_2/loss_4/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_2/loss_4/pow_grad/Reshape_1Reshape!gradients_2/loss_4/pow_grad/Sum_1#gradients_2/loss_4/pow_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
В
,gradients_2/loss_4/pow_grad/tuple/group_depsNoOp$^gradients_2/loss_4/pow_grad/Reshape&^gradients_2/loss_4/pow_grad/Reshape_1
ю
4gradients_2/loss_4/pow_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/pow_grad/Reshape-^gradients_2/loss_4/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_2/loss_4/pow_grad/Reshape
у
6gradients_2/loss_4/pow_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/pow_grad/Reshape_1-^gradients_2/loss_4/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_grad/Reshape_1
|
+gradients_2/loss_4/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_2/loss_4/Sum_3_grad/ReshapeReshape8gradients_2/loss_4/mul_2_grad/tuple/control_dependency_1+gradients_2/loss_4/Sum_3_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_2/loss_4/Sum_3_grad/ShapeShapeloss_4/pow_1*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_2/loss_4/Sum_3_grad/TileTile%gradients_2/loss_4/Sum_3_grad/Reshape#gradients_2/loss_4/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_2/loss_4/pow_2_grad/ShapeShapeloss_4/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_2_grad/Shape%gradients_2/loss_4/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_2/loss_4/pow_2_grad/mulMul"gradients_2/loss_4/Sum_4_grad/Tileloss_4/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_2/loss_4/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_2_grad/subSubloss_4/pow_2/y#gradients_2/loss_4/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_2_grad/PowPowloss_4/pos_item_bias!gradients_2/loss_4/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_2/loss_4/pow_2_grad/mul_1Mul!gradients_2/loss_4/pow_2_grad/mul!gradients_2/loss_4/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_2/loss_4/pow_2_grad/SumSum#gradients_2/loss_4/pow_2_grad/mul_13gradients_2/loss_4/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/pow_2_grad/ReshapeReshape!gradients_2/loss_4/pow_2_grad/Sum#gradients_2/loss_4/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_2/loss_4/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_2_grad/GreaterGreaterloss_4/pos_item_bias'gradients_2/loss_4/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_2/loss_4/pow_2_grad/LogLogloss_4/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_2/loss_4/pow_2_grad/zeros_like	ZerosLikeloss_4/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_2/loss_4/pow_2_grad/SelectSelect%gradients_2/loss_4/pow_2_grad/Greater!gradients_2/loss_4/pow_2_grad/Log(gradients_2/loss_4/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_2/loss_4/pow_2_grad/mul_2Mul"gradients_2/loss_4/Sum_4_grad/Tileloss_4/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_2/loss_4/pow_2_grad/mul_3Mul#gradients_2/loss_4/pow_2_grad/mul_2$gradients_2/loss_4/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_2/loss_4/pow_2_grad/Sum_1Sum#gradients_2/loss_4/pow_2_grad/mul_35gradients_2/loss_4/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_2_grad/Reshape_1Reshape#gradients_2/loss_4/pow_2_grad/Sum_1%gradients_2/loss_4/pow_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/pow_2_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_2_grad/Reshape(^gradients_2/loss_4/pow_2_grad/Reshape_1
В
6gradients_2/loss_4/pow_2_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_2_grad/Reshape/^gradients_2/loss_4/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_2_grad/Reshape
ы
8gradients_2/loss_4/pow_2_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_2_grad/Reshape_1/^gradients_2/loss_4/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_2_grad/Reshape_1
s
#gradients_2/loss_4/pow_3_grad/ShapeShapeloss_4/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_3_grad/Shape%gradients_2/loss_4/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_2/loss_4/pow_3_grad/mulMul"gradients_2/loss_4/Sum_5_grad/Tileloss_4/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_2/loss_4/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_3_grad/subSubloss_4/pow_3/y#gradients_2/loss_4/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_3_grad/PowPowloss_4/neg_items!gradients_2/loss_4/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_2/loss_4/pow_3_grad/mul_1Mul!gradients_2/loss_4/pow_3_grad/mul!gradients_2/loss_4/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_2/loss_4/pow_3_grad/SumSum#gradients_2/loss_4/pow_3_grad/mul_13gradients_2/loss_4/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_2/loss_4/pow_3_grad/ReshapeReshape!gradients_2/loss_4/pow_3_grad/Sum#gradients_2/loss_4/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_2/loss_4/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_3_grad/GreaterGreaterloss_4/neg_items'gradients_2/loss_4/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_2/loss_4/pow_3_grad/LogLogloss_4/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_2/loss_4/pow_3_grad/zeros_like	ZerosLikeloss_4/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_2/loss_4/pow_3_grad/SelectSelect%gradients_2/loss_4/pow_3_grad/Greater!gradients_2/loss_4/pow_3_grad/Log(gradients_2/loss_4/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_2/loss_4/pow_3_grad/mul_2Mul"gradients_2/loss_4/Sum_5_grad/Tileloss_4/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_2/loss_4/pow_3_grad/mul_3Mul#gradients_2/loss_4/pow_3_grad/mul_2$gradients_2/loss_4/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_2/loss_4/pow_3_grad/Sum_1Sum#gradients_2/loss_4/pow_3_grad/mul_35gradients_2/loss_4/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_3_grad/Reshape_1Reshape#gradients_2/loss_4/pow_3_grad/Sum_1%gradients_2/loss_4/pow_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/pow_3_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_3_grad/Reshape(^gradients_2/loss_4/pow_3_grad/Reshape_1
Ж
6gradients_2/loss_4/pow_3_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_3_grad/Reshape/^gradients_2/loss_4/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_3_grad/Reshape
ы
8gradients_2/loss_4/pow_3_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_3_grad/Reshape_1/^gradients_2/loss_4/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_3_grad/Reshape_1
ј
+gradients_2/loss_4/Sigmoid_grad/SigmoidGradSigmoidGradloss_4/SigmoidFgradients_2/loss_4/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_2/loss_4/pow_1_grad/ShapeShapeloss_4/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_2/loss_4/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_2/loss_4/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/pow_1_grad/Shape%gradients_2/loss_4/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_2/loss_4/pow_1_grad/mulMul"gradients_2/loss_4/Sum_3_grad/Tileloss_4/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_2/loss_4/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_2/loss_4/pow_1_grad/subSubloss_4/pow_1/y#gradients_2/loss_4/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_2/loss_4/pow_1_grad/PowPowloss_4/pos_items!gradients_2/loss_4/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_2/loss_4/pow_1_grad/mul_1Mul!gradients_2/loss_4/pow_1_grad/mul!gradients_2/loss_4/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_2/loss_4/pow_1_grad/SumSum#gradients_2/loss_4/pow_1_grad/mul_13gradients_2/loss_4/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_2/loss_4/pow_1_grad/ReshapeReshape!gradients_2/loss_4/pow_1_grad/Sum#gradients_2/loss_4/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_2/loss_4/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_2/loss_4/pow_1_grad/GreaterGreaterloss_4/pos_items'gradients_2/loss_4/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_2/loss_4/pow_1_grad/LogLogloss_4/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_2/loss_4/pow_1_grad/zeros_like	ZerosLikeloss_4/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_2/loss_4/pow_1_grad/SelectSelect%gradients_2/loss_4/pow_1_grad/Greater!gradients_2/loss_4/pow_1_grad/Log(gradients_2/loss_4/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_2/loss_4/pow_1_grad/mul_2Mul"gradients_2/loss_4/Sum_3_grad/Tileloss_4/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_2/loss_4/pow_1_grad/mul_3Mul#gradients_2/loss_4/pow_1_grad/mul_2$gradients_2/loss_4/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_2/loss_4/pow_1_grad/Sum_1Sum#gradients_2/loss_4/pow_1_grad/mul_35gradients_2/loss_4/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_2/loss_4/pow_1_grad/Reshape_1Reshape#gradients_2/loss_4/pow_1_grad/Sum_1%gradients_2/loss_4/pow_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_2/loss_4/pow_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/pow_1_grad/Reshape(^gradients_2/loss_4/pow_1_grad/Reshape_1
Ж
6gradients_2/loss_4/pow_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/pow_1_grad/Reshape/^gradients_2/loss_4/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/pow_1_grad/Reshape
ы
8gradients_2/loss_4/pow_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/pow_1_grad/Reshape_1/^gradients_2/loss_4/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_2/loss_4/pow_1_grad/Reshape_1
m
!gradients_2/loss_4/add_grad/ShapeShapeloss_4/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_2/loss_4/add_grad/Shape_1Shape
loss_4/Sum*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_2/loss_4/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/add_grad/Shape#gradients_2/loss_4/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_2/loss_4/add_grad/SumSum+gradients_2/loss_4/Sigmoid_grad/SigmoidGrad1gradients_2/loss_4/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_2/loss_4/add_grad/ReshapeReshapegradients_2/loss_4/add_grad/Sum!gradients_2/loss_4/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
!gradients_2/loss_4/add_grad/Sum_1Sum+gradients_2/loss_4/Sigmoid_grad/SigmoidGrad3gradients_2/loss_4/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/add_grad/Reshape_1Reshape!gradients_2/loss_4/add_grad/Sum_1#gradients_2/loss_4/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
В
,gradients_2/loss_4/add_grad/tuple/group_depsNoOp$^gradients_2/loss_4/add_grad/Reshape&^gradients_2/loss_4/add_grad/Reshape_1
ъ
4gradients_2/loss_4/add_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/add_grad/Reshape-^gradients_2/loss_4/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_2/loss_4/add_grad/Reshape
А
6gradients_2/loss_4/add_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/add_grad/Reshape_1-^gradients_2/loss_4/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/add_grad/Reshape_1
w
#gradients_2/loss_4/sub_1_grad/ShapeShapeloss_4/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_2/loss_4/sub_1_grad/Shape_1Shapeloss_4/neg_item_bias*
_output_shapes
:*
T0*
out_type0
’
3gradients_2/loss_4/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_2/loss_4/sub_1_grad/Shape%gradients_2/loss_4/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_2/loss_4/sub_1_grad/SumSum4gradients_2/loss_4/add_grad/tuple/control_dependency3gradients_2/loss_4/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_2/loss_4/sub_1_grad/ReshapeReshape!gradients_2/loss_4/sub_1_grad/Sum#gradients_2/loss_4/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
„
#gradients_2/loss_4/sub_1_grad/Sum_1Sum4gradients_2/loss_4/add_grad/tuple/control_dependency5gradients_2/loss_4/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_2/loss_4/sub_1_grad/NegNeg#gradients_2/loss_4/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_2/loss_4/sub_1_grad/Reshape_1Reshape!gradients_2/loss_4/sub_1_grad/Neg%gradients_2/loss_4/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
И
.gradients_2/loss_4/sub_1_grad/tuple/group_depsNoOp&^gradients_2/loss_4/sub_1_grad/Reshape(^gradients_2/loss_4/sub_1_grad/Reshape_1
В
6gradients_2/loss_4/sub_1_grad/tuple/control_dependencyIdentity%gradients_2/loss_4/sub_1_grad/Reshape/^gradients_2/loss_4/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_2/loss_4/sub_1_grad/Reshape
И
8gradients_2/loss_4/sub_1_grad/tuple/control_dependency_1Identity'gradients_2/loss_4/sub_1_grad/Reshape_1/^gradients_2/loss_4/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*:
_class0
.,loc:@gradients_2/loss_4/sub_1_grad/Reshape_1
k
!gradients_2/loss_4/Sum_grad/ShapeShape
loss_4/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_2/loss_4/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_2/loss_4/Sum_grad/addAddloss_4/Sum/reduction_indices gradients_2/loss_4/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_2/loss_4/Sum_grad/modFloorModgradients_2/loss_4/Sum_grad/add gradients_2/loss_4/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_2/loss_4/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_2/loss_4/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_2/loss_4/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_2/loss_4/Sum_grad/rangeRange'gradients_2/loss_4/Sum_grad/range/start gradients_2/loss_4/Sum_grad/Size'gradients_2/loss_4/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_2/loss_4/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_2/loss_4/Sum_grad/FillFill#gradients_2/loss_4/Sum_grad/Shape_1&gradients_2/loss_4/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_2/loss_4/Sum_grad/DynamicStitchDynamicStitch!gradients_2/loss_4/Sum_grad/rangegradients_2/loss_4/Sum_grad/mod!gradients_2/loss_4/Sum_grad/Shape gradients_2/loss_4/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
T0*
N
g
%gradients_2/loss_4/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_2/loss_4/Sum_grad/MaximumMaximum)gradients_2/loss_4/Sum_grad/DynamicStitch%gradients_2/loss_4/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_2/loss_4/Sum_grad/floordivFloorDiv!gradients_2/loss_4/Sum_grad/Shape#gradients_2/loss_4/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_2/loss_4/Sum_grad/ReshapeReshape6gradients_2/loss_4/add_grad/tuple/control_dependency_1)gradients_2/loss_4/Sum_grad/DynamicStitch*
_output_shapes
:*
Tshape0*
T0
Ј
 gradients_2/loss_4/Sum_grad/TileTile#gradients_2/loss_4/Sum_grad/Reshape$gradients_2/loss_4/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_2/AddNAddN6gradients_2/loss_4/pow_2_grad/tuple/control_dependency6gradients_2/loss_4/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_2/loss_4/pow_2_grad/Reshape
†
+gradients_2/loss_4/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_2/item_bias
Е
*gradients_2/loss_4/pos_item_bias_grad/SizeSize placeholders_2/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_2/loss_4/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_2/loss_4/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_2/loss_4/pos_item_bias_grad/Size4gradients_2/loss_4/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_2/loss_4/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_2/loss_4/pos_item_bias_grad/strided_sliceStridedSlice+gradients_2/loss_4/pos_item_bias_grad/Shape9gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_1;gradients_2/loss_4/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_2/loss_4/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_2/loss_4/pos_item_bias_grad/concatConcatV20gradients_2/loss_4/pos_item_bias_grad/ExpandDims3gradients_2/loss_4/pos_item_bias_grad/strided_slice1gradients_2/loss_4/pos_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
і
-gradients_2/loss_4/pos_item_bias_grad/ReshapeReshapegradients_2/AddN,gradients_2/loss_4/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_2/loss_4/pos_item_bias_grad/Reshape_1Reshape placeholders_2/sampled_pos_items0gradients_2/loss_4/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
э
gradients_2/AddN_1AddN6gradients_2/loss_4/pow_4_grad/tuple/control_dependency8gradients_2/loss_4/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_2/loss_4/pow_4_grad/Reshape
†
+gradients_2/loss_4/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_2/item_bias
Е
*gradients_2/loss_4/neg_item_bias_grad/SizeSize placeholders_2/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_2/loss_4/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_2/loss_4/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_2/loss_4/neg_item_bias_grad/Size4gradients_2/loss_4/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_2/loss_4/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_2/loss_4/neg_item_bias_grad/strided_sliceStridedSlice+gradients_2/loss_4/neg_item_bias_grad/Shape9gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_1;gradients_2/loss_4/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_2/loss_4/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_2/loss_4/neg_item_bias_grad/concatConcatV20gradients_2/loss_4/neg_item_bias_grad/ExpandDims3gradients_2/loss_4/neg_item_bias_grad/strided_slice1gradients_2/loss_4/neg_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ґ
-gradients_2/loss_4/neg_item_bias_grad/ReshapeReshapegradients_2/AddN_1,gradients_2/loss_4/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_2/loss_4/neg_item_bias_grad/Reshape_1Reshape placeholders_2/sampled_neg_items0gradients_2/loss_4/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
m
!gradients_2/loss_4/mul_grad/ShapeShapeloss_4/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_2/loss_4/mul_grad/Shape_1Shape
loss_4/sub*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_2/loss_4/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/mul_grad/Shape#gradients_2/loss_4/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_2/loss_4/mul_grad/mulMul gradients_2/loss_4/Sum_grad/Tile
loss_4/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_2/loss_4/mul_grad/SumSumgradients_2/loss_4/mul_grad/mul1gradients_2/loss_4/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_2/loss_4/mul_grad/ReshapeReshapegradients_2/loss_4/mul_grad/Sum!gradients_2/loss_4/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
К
!gradients_2/loss_4/mul_grad/mul_1Mulloss_4/users gradients_2/loss_4/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_2/loss_4/mul_grad/Sum_1Sum!gradients_2/loss_4/mul_grad/mul_13gradients_2/loss_4/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_2/loss_4/mul_grad/Reshape_1Reshape!gradients_2/loss_4/mul_grad/Sum_1#gradients_2/loss_4/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_2/loss_4/mul_grad/tuple/group_depsNoOp$^gradients_2/loss_4/mul_grad/Reshape&^gradients_2/loss_4/mul_grad/Reshape_1
ю
4gradients_2/loss_4/mul_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/mul_grad/Reshape-^gradients_2/loss_4/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_2/loss_4/mul_grad/Reshape
Д
6gradients_2/loss_4/mul_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/mul_grad/Reshape_1-^gradients_2/loss_4/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/mul_grad/Reshape_1
Y
gradients_2/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_2/concatConcatV2-gradients_2/loss_4/pos_item_bias_grad/Reshape-gradients_2/loss_4/neg_item_bias_grad/Reshapegradients_2/concat/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_2/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_2/concat_1ConcatV2/gradients_2/loss_4/pos_item_bias_grad/Reshape_1/gradients_2/loss_4/neg_item_bias_grad/Reshape_1gradients_2/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
щ
gradients_2/AddN_2AddN4gradients_2/loss_4/pow_grad/tuple/control_dependency4gradients_2/loss_4/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*6
_class,
*(loc:@gradients_2/loss_4/pow_grad/Reshape
°
#gradients_2/loss_4/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_2/user_factors
y
"gradients_2/loss_4/users_grad/SizeSizeplaceholders_2/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_2/loss_4/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_2/loss_4/users_grad/ExpandDims
ExpandDims"gradients_2/loss_4/users_grad/Size,gradients_2/loss_4/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_2/loss_4/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_2/loss_4/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_2/loss_4/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_2/loss_4/users_grad/strided_sliceStridedSlice#gradients_2/loss_4/users_grad/Shape1gradients_2/loss_4/users_grad/strided_slice/stack3gradients_2/loss_4/users_grad/strided_slice/stack_13gradients_2/loss_4/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_2/loss_4/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_2/loss_4/users_grad/concatConcatV2(gradients_2/loss_4/users_grad/ExpandDims+gradients_2/loss_4/users_grad/strided_slice)gradients_2/loss_4/users_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
≥
%gradients_2/loss_4/users_grad/ReshapeReshapegradients_2/AddN_2$gradients_2/loss_4/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
ґ
'gradients_2/loss_4/users_grad/Reshape_1Reshapeplaceholders_2/sampled_users(gradients_2/loss_4/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
q
!gradients_2/loss_4/sub_grad/ShapeShapeloss_4/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_2/loss_4/sub_grad/Shape_1Shapeloss_4/neg_items*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_2/loss_4/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_2/loss_4/sub_grad/Shape#gradients_2/loss_4/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_2/loss_4/sub_grad/SumSum6gradients_2/loss_4/mul_grad/tuple/control_dependency_11gradients_2/loss_4/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_2/loss_4/sub_grad/ReshapeReshapegradients_2/loss_4/sub_grad/Sum!gradients_2/loss_4/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
’
!gradients_2/loss_4/sub_grad/Sum_1Sum6gradients_2/loss_4/mul_grad/tuple/control_dependency_13gradients_2/loss_4/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_2/loss_4/sub_grad/NegNeg!gradients_2/loss_4/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_2/loss_4/sub_grad/Reshape_1Reshapegradients_2/loss_4/sub_grad/Neg#gradients_2/loss_4/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_2/loss_4/sub_grad/tuple/group_depsNoOp$^gradients_2/loss_4/sub_grad/Reshape&^gradients_2/loss_4/sub_grad/Reshape_1
ю
4gradients_2/loss_4/sub_grad/tuple/control_dependencyIdentity#gradients_2/loss_4/sub_grad/Reshape-^gradients_2/loss_4/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_2/loss_4/sub_grad/Reshape
Д
6gradients_2/loss_4/sub_grad/tuple/control_dependency_1Identity%gradients_2/loss_4/sub_grad/Reshape_1-^gradients_2/loss_4/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_2/loss_4/sub_grad/Reshape_1
э
gradients_2/AddN_3AddN6gradients_2/loss_4/pow_1_grad/tuple/control_dependency4gradients_2/loss_4/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_2/loss_4/pow_1_grad/Reshape
•
'gradients_2/loss_4/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_2/item_factors
Б
&gradients_2/loss_4/pos_items_grad/SizeSize placeholders_2/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_2/loss_4/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_2/loss_4/pos_items_grad/ExpandDims
ExpandDims&gradients_2/loss_4/pos_items_grad/Size0gradients_2/loss_4/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_2/loss_4/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_2/loss_4/pos_items_grad/strided_sliceStridedSlice'gradients_2/loss_4/pos_items_grad/Shape5gradients_2/loss_4/pos_items_grad/strided_slice/stack7gradients_2/loss_4/pos_items_grad/strided_slice/stack_17gradients_2/loss_4/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_2/loss_4/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_2/loss_4/pos_items_grad/concatConcatV2,gradients_2/loss_4/pos_items_grad/ExpandDims/gradients_2/loss_4/pos_items_grad/strided_slice-gradients_2/loss_4/pos_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_2/loss_4/pos_items_grad/ReshapeReshapegradients_2/AddN_3(gradients_2/loss_4/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_2/loss_4/pos_items_grad/Reshape_1Reshape placeholders_2/sampled_pos_items,gradients_2/loss_4/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
€
gradients_2/AddN_4AddN6gradients_2/loss_4/pow_3_grad/tuple/control_dependency6gradients_2/loss_4/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_2/loss_4/pow_3_grad/Reshape
•
'gradients_2/loss_4/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_2/item_factors
Б
&gradients_2/loss_4/neg_items_grad/SizeSize placeholders_2/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_2/loss_4/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_2/loss_4/neg_items_grad/ExpandDims
ExpandDims&gradients_2/loss_4/neg_items_grad/Size0gradients_2/loss_4/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_2/loss_4/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_2/loss_4/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_2/loss_4/neg_items_grad/strided_sliceStridedSlice'gradients_2/loss_4/neg_items_grad/Shape5gradients_2/loss_4/neg_items_grad/strided_slice/stack7gradients_2/loss_4/neg_items_grad/strided_slice/stack_17gradients_2/loss_4/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_2/loss_4/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_2/loss_4/neg_items_grad/concatConcatV2,gradients_2/loss_4/neg_items_grad/ExpandDims/gradients_2/loss_4/neg_items_grad/strided_slice-gradients_2/loss_4/neg_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_2/loss_4/neg_items_grad/ReshapeReshapegradients_2/AddN_4(gradients_2/loss_4/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_2/loss_4/neg_items_grad/Reshape_1Reshape placeholders_2/sampled_neg_items,gradients_2/loss_4/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
[
gradients_2/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_2/concat_2ConcatV2)gradients_2/loss_4/pos_items_grad/Reshape)gradients_2/loss_4/neg_items_grad/Reshapegradients_2/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_2/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_2/concat_3ConcatV2+gradients_2/loss_4/pos_items_grad/Reshape_1+gradients_2/loss_4/neg_items_grad/Reshape_1gradients_2/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
d
GradientDescent_2/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_2/update_variables_2/user_factors/mulMul%gradients_2/loss_4/users_grad/ReshapeGradientDescent_2/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_2/user_factors
Њ
<GradientDescent_2/update_variables_2/user_factors/ScatterSub
ScatterSubvariables_2/user_factors'gradients_2/loss_4/users_grad/Reshape_15GradientDescent_2/update_variables_2/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_2/user_factors
џ
5GradientDescent_2/update_variables_2/item_factors/mulMulgradients_2/concat_2GradientDescent_2/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_2/item_factors
Ђ
<GradientDescent_2/update_variables_2/item_factors/ScatterSub
ScatterSubvariables_2/item_factorsgradients_2/concat_35GradientDescent_2/update_variables_2/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_2/item_factors
∆
2GradientDescent_2/update_variables_2/item_bias/mulMulgradients_2/concatGradientDescent_2/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_2/item_bias
Ы
9GradientDescent_2/update_variables_2/item_bias/ScatterSub
ScatterSubvariables_2/item_biasgradients_2/concat_12GradientDescent_2/update_variables_2/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_2/item_bias
”
GradientDescent_2NoOp=^GradientDescent_2/update_variables_2/user_factors/ScatterSub=^GradientDescent_2/update_variables_2/item_factors/ScatterSub:^GradientDescent_2/update_variables_2/item_bias/ScatterSub
R
loss_5/tagsConst*
valueB Bloss_5*
_output_shapes
: *
dtype0
S
loss_5ScalarSummaryloss_5/tagsloss_4/sub_2*
_output_shapes
: *
T0
]
Merge_2/MergeSummaryMergeSummaryloss_1loss_3loss_5*
_output_shapes
: *
N
±
init_2NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign ^variables_2/user_factors/Assign ^variables_2/item_factors/Assign^variables_2/item_bias/Assign
j
placeholders_3/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_3/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_3/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_3/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_3/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_3/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_3/truncated_normal/TruncatedNormalTruncatedNormal"variables_3/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_3/truncated_normal/mulMul,variables_3/truncated_normal/TruncatedNormal#variables_3/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_3/truncated_normalAdd variables_3/truncated_normal/mul!variables_3/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_3/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_3/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_3/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_3/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_3/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_3/truncated_normal_1/mulMul.variables_3/truncated_normal_1/TruncatedNormal%variables_3/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_3/truncated_normal_1Add"variables_3/truncated_normal_1/mul#variables_3/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_3/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_3/user_factors/AssignAssignvariables_3/user_factorsvariables_3/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_3/user_factors
Ъ
variables_3/user_factors/readIdentityvariables_3/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_3/user_factors
О
variables_3/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_3/item_factors/AssignAssignvariables_3/item_factorsvariables_3/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_3/item_factors
Ъ
variables_3/item_factors/readIdentityvariables_3/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_3/item_factors
`
variables_3/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_3/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_3/item_bias/AssignAssignvariables_3/item_biasvariables_3/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_3/item_bias
Н
variables_3/item_bias/readIdentityvariables_3/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_3/item_bias
≥
loss_6/usersGathervariables_3/user_factors/readplaceholders_3/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_6/pos_itemsGathervariables_3/item_factors/read placeholders_3/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_6/neg_itemsGathervariables_3/item_factors/read placeholders_3/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_6/pos_item_biasGathervariables_3/item_bias/read placeholders_3/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_6/neg_item_biasGathervariables_3/item_bias/read placeholders_3/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_6/subSubloss_6/pos_itemsloss_6/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_6/mulMulloss_6/users
loss_6/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_6/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_6/SumSum
loss_6/mulloss_6/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_6/sub_1Subloss_6/pos_item_biasloss_6/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_6/addAddloss_6/sub_1
loss_6/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_6/SigmoidSigmoid
loss_6/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_6/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_6/clip_by_value/MinimumMinimumloss_6/Sigmoidloss_6/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_6/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_6/clip_by_valueMaximumloss_6/clip_by_value/Minimumloss_6/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_6/LogLogloss_6/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_6/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_6/Sum_1Sum
loss_6/Logloss_6/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_6/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_6/powPowloss_6/usersloss_6/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_6/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_6/Sum_2Sum
loss_6/powloss_6/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_6/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_6/mul_1Mulloss_6/mul_1/xloss_6/Sum_2*
_output_shapes
: *
T0
S
loss_6/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_1Powloss_6/pos_itemsloss_6/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_6/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_6/Sum_3Sumloss_6/pow_1loss_6/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_6/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_6/mul_2Mulloss_6/mul_2/xloss_6/Sum_3*
_output_shapes
: *
T0
S
loss_6/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_2Powloss_6/pos_item_biasloss_6/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_6/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_6/Sum_4Sumloss_6/pow_2loss_6/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_6/add_1Addloss_6/mul_2loss_6/Sum_4*
_output_shapes
: *
T0
S
loss_6/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_3Powloss_6/neg_itemsloss_6/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_6/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_6/Sum_5Sumloss_6/pow_3loss_6/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_6/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_6/mul_3Mulloss_6/mul_3/xloss_6/Sum_5*
_output_shapes
: *
T0
S
loss_6/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_6/pow_4Powloss_6/neg_item_biasloss_6/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_6/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_6/Sum_6Sumloss_6/pow_4loss_6/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_6/add_2Addloss_6/mul_3loss_6/Sum_6*
_output_shapes
: *
T0
P
loss_6/add_3Addloss_6/mul_1loss_6/add_1*
_output_shapes
: *
T0
P
loss_6/add_4Addloss_6/add_3loss_6/add_2*
_output_shapes
: *
T0
P
loss_6/sub_2Subloss_6/add_4loss_6/Sum_1*
_output_shapes
: *
T0
T
gradients_3/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_3/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_3/FillFillgradients_3/Shapegradients_3/Const*
_output_shapes
: *
T0
f
#gradients_3/loss_6/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/sub_2_grad/Shape%gradients_3/loss_6/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_3/loss_6/sub_2_grad/SumSumgradients_3/Fill3gradients_3/loss_6/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/sub_2_grad/ReshapeReshape!gradients_3/loss_6/sub_2_grad/Sum#gradients_3/loss_6/sub_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
≥
#gradients_3/loss_6/sub_2_grad/Sum_1Sumgradients_3/Fill5gradients_3/loss_6/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_3/loss_6/sub_2_grad/NegNeg#gradients_3/loss_6/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_3/loss_6/sub_2_grad/Reshape_1Reshape!gradients_3/loss_6/sub_2_grad/Neg%gradients_3/loss_6/sub_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/sub_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/sub_2_grad/Reshape(^gradients_3/loss_6/sub_2_grad/Reshape_1
х
6gradients_3/loss_6/sub_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/sub_2_grad/Reshape/^gradients_3/loss_6/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/sub_2_grad/Reshape
ы
8gradients_3/loss_6/sub_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/sub_2_grad/Reshape_1/^gradients_3/loss_6/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/sub_2_grad/Reshape_1
f
#gradients_3/loss_6/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_4_grad/Shape%gradients_3/loss_6/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_3/loss_6/add_4_grad/SumSum6gradients_3/loss_6/sub_2_grad/tuple/control_dependency3gradients_3/loss_6/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_4_grad/ReshapeReshape!gradients_3/loss_6/add_4_grad/Sum#gradients_3/loss_6/add_4_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_3/loss_6/add_4_grad/Sum_1Sum6gradients_3/loss_6/sub_2_grad/tuple/control_dependency5gradients_3/loss_6/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_4_grad/Reshape_1Reshape#gradients_3/loss_6/add_4_grad/Sum_1%gradients_3/loss_6/add_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/add_4_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_4_grad/Reshape(^gradients_3/loss_6/add_4_grad/Reshape_1
х
6gradients_3/loss_6/add_4_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_4_grad/Reshape/^gradients_3/loss_6/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_4_grad/Reshape
ы
8gradients_3/loss_6/add_4_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_4_grad/Reshape_1/^gradients_3/loss_6/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_4_grad/Reshape_1
u
+gradients_3/loss_6/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_3/loss_6/Sum_1_grad/ReshapeReshape8gradients_3/loss_6/sub_2_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_1_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
m
#gradients_3/loss_6/Sum_1_grad/ShapeShape
loss_6/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_3/loss_6/Sum_1_grad/TileTile%gradients_3/loss_6/Sum_1_grad/Reshape#gradients_3/loss_6/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_3/loss_6/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_3_grad/Shape%gradients_3/loss_6/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_3/loss_6/add_3_grad/SumSum6gradients_3/loss_6/add_4_grad/tuple/control_dependency3gradients_3/loss_6/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_3_grad/ReshapeReshape!gradients_3/loss_6/add_3_grad/Sum#gradients_3/loss_6/add_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_3/loss_6/add_3_grad/Sum_1Sum6gradients_3/loss_6/add_4_grad/tuple/control_dependency5gradients_3/loss_6/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_3_grad/Reshape_1Reshape#gradients_3/loss_6/add_3_grad/Sum_1%gradients_3/loss_6/add_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/add_3_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_3_grad/Reshape(^gradients_3/loss_6/add_3_grad/Reshape_1
х
6gradients_3/loss_6/add_3_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_3_grad/Reshape/^gradients_3/loss_6/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_3_grad/Reshape
ы
8gradients_3/loss_6/add_3_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_3_grad/Reshape_1/^gradients_3/loss_6/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_3_grad/Reshape_1
f
#gradients_3/loss_6/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_2_grad/Shape%gradients_3/loss_6/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_3/loss_6/add_2_grad/SumSum8gradients_3/loss_6/add_4_grad/tuple/control_dependency_13gradients_3/loss_6/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_2_grad/ReshapeReshape!gradients_3/loss_6/add_2_grad/Sum#gradients_3/loss_6/add_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_3/loss_6/add_2_grad/Sum_1Sum8gradients_3/loss_6/add_4_grad/tuple/control_dependency_15gradients_3/loss_6/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_2_grad/Reshape_1Reshape#gradients_3/loss_6/add_2_grad/Sum_1%gradients_3/loss_6/add_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/add_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_2_grad/Reshape(^gradients_3/loss_6/add_2_grad/Reshape_1
х
6gradients_3/loss_6/add_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_2_grad/Reshape/^gradients_3/loss_6/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_2_grad/Reshape
ы
8gradients_3/loss_6/add_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_2_grad/Reshape_1/^gradients_3/loss_6/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_2_grad/Reshape_1
Э
&gradients_3/loss_6/Log_grad/Reciprocal
Reciprocalloss_6/clip_by_value#^gradients_3/loss_6/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_3/loss_6/Log_grad/mulMul"gradients_3/loss_6/Sum_1_grad/Tile&gradients_3/loss_6/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_3/loss_6/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/mul_1_grad/Shape%gradients_3/loss_6/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_3/loss_6/mul_1_grad/mulMul6gradients_3/loss_6/add_3_grad/tuple/control_dependencyloss_6/Sum_2*
_output_shapes
: *
T0
ј
!gradients_3/loss_6/mul_1_grad/SumSum!gradients_3/loss_6/mul_1_grad/mul3gradients_3/loss_6/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/mul_1_grad/ReshapeReshape!gradients_3/loss_6/mul_1_grad/Sum#gradients_3/loss_6/mul_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_3/loss_6/mul_1_grad/mul_1Mulloss_6/mul_1/x6gradients_3/loss_6/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_3/loss_6/mul_1_grad/Sum_1Sum#gradients_3/loss_6/mul_1_grad/mul_15gradients_3/loss_6/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/mul_1_grad/Reshape_1Reshape#gradients_3/loss_6/mul_1_grad/Sum_1%gradients_3/loss_6/mul_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/mul_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/mul_1_grad/Reshape(^gradients_3/loss_6/mul_1_grad/Reshape_1
х
6gradients_3/loss_6/mul_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/mul_1_grad/Reshape/^gradients_3/loss_6/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_1_grad/Reshape
ы
8gradients_3/loss_6/mul_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/mul_1_grad/Reshape_1/^gradients_3/loss_6/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/mul_1_grad/Reshape_1
f
#gradients_3/loss_6/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/add_1_grad/Shape%gradients_3/loss_6/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_3/loss_6/add_1_grad/SumSum8gradients_3/loss_6/add_3_grad/tuple/control_dependency_13gradients_3/loss_6/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/add_1_grad/ReshapeReshape!gradients_3/loss_6/add_1_grad/Sum#gradients_3/loss_6/add_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_3/loss_6/add_1_grad/Sum_1Sum8gradients_3/loss_6/add_3_grad/tuple/control_dependency_15gradients_3/loss_6/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/add_1_grad/Reshape_1Reshape#gradients_3/loss_6/add_1_grad/Sum_1%gradients_3/loss_6/add_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/add_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/add_1_grad/Reshape(^gradients_3/loss_6/add_1_grad/Reshape_1
х
6gradients_3/loss_6/add_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/add_1_grad/Reshape/^gradients_3/loss_6/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/add_1_grad/Reshape
ы
8gradients_3/loss_6/add_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/add_1_grad/Reshape_1/^gradients_3/loss_6/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/add_1_grad/Reshape_1
f
#gradients_3/loss_6/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/mul_3_grad/Shape%gradients_3/loss_6/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_3/loss_6/mul_3_grad/mulMul6gradients_3/loss_6/add_2_grad/tuple/control_dependencyloss_6/Sum_5*
_output_shapes
: *
T0
ј
!gradients_3/loss_6/mul_3_grad/SumSum!gradients_3/loss_6/mul_3_grad/mul3gradients_3/loss_6/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/mul_3_grad/ReshapeReshape!gradients_3/loss_6/mul_3_grad/Sum#gradients_3/loss_6/mul_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_3/loss_6/mul_3_grad/mul_1Mulloss_6/mul_3/x6gradients_3/loss_6/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_3/loss_6/mul_3_grad/Sum_1Sum#gradients_3/loss_6/mul_3_grad/mul_15gradients_3/loss_6/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/mul_3_grad/Reshape_1Reshape#gradients_3/loss_6/mul_3_grad/Sum_1%gradients_3/loss_6/mul_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/mul_3_grad/tuple/group_depsNoOp&^gradients_3/loss_6/mul_3_grad/Reshape(^gradients_3/loss_6/mul_3_grad/Reshape_1
х
6gradients_3/loss_6/mul_3_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/mul_3_grad/Reshape/^gradients_3/loss_6/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_3_grad/Reshape
ы
8gradients_3/loss_6/mul_3_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/mul_3_grad/Reshape_1/^gradients_3/loss_6/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/mul_3_grad/Reshape_1
u
+gradients_3/loss_6/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_3/loss_6/Sum_6_grad/ReshapeReshape8gradients_3/loss_6/add_2_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_6_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_3/loss_6/Sum_6_grad/ShapeShapeloss_6/pow_4*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_3/loss_6/Sum_6_grad/TileTile%gradients_3/loss_6/Sum_6_grad/Reshape#gradients_3/loss_6/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_3/loss_6/clip_by_value_grad/ShapeShapeloss_6/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_3/loss_6/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_3/loss_6/clip_by_value_grad/Shape_2Shapegradients_3/loss_6/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_3/loss_6/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_3/loss_6/clip_by_value_grad/zerosFill-gradients_3/loss_6/clip_by_value_grad/Shape_21gradients_3/loss_6/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_3/loss_6/clip_by_value_grad/GreaterEqualGreaterEqualloss_6/clip_by_value/Minimumloss_6/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_3/loss_6/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_3/loss_6/clip_by_value_grad/Shape-gradients_3/loss_6/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_3/loss_6/clip_by_value_grad/SelectSelect2gradients_3/loss_6/clip_by_value_grad/GreaterEqualgradients_3/loss_6/Log_grad/mul+gradients_3/loss_6/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_3/loss_6/clip_by_value_grad/LogicalNot
LogicalNot2gradients_3/loss_6/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_3/loss_6/clip_by_value_grad/Select_1Select0gradients_3/loss_6/clip_by_value_grad/LogicalNotgradients_3/loss_6/Log_grad/mul+gradients_3/loss_6/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_3/loss_6/clip_by_value_grad/SumSum,gradients_3/loss_6/clip_by_value_grad/Select;gradients_3/loss_6/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_3/loss_6/clip_by_value_grad/ReshapeReshape)gradients_3/loss_6/clip_by_value_grad/Sum+gradients_3/loss_6/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
б
+gradients_3/loss_6/clip_by_value_grad/Sum_1Sum.gradients_3/loss_6/clip_by_value_grad/Select_1=gradients_3/loss_6/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_3/loss_6/clip_by_value_grad/Reshape_1Reshape+gradients_3/loss_6/clip_by_value_grad/Sum_1-gradients_3/loss_6/clip_by_value_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
†
6gradients_3/loss_6/clip_by_value_grad/tuple/group_depsNoOp.^gradients_3/loss_6/clip_by_value_grad/Reshape0^gradients_3/loss_6/clip_by_value_grad/Reshape_1
Ґ
>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_3/loss_6/clip_by_value_grad/Reshape7^gradients_3/loss_6/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_3/loss_6/clip_by_value_grad/Reshape
Ы
@gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_3/loss_6/clip_by_value_grad/Reshape_17^gradients_3/loss_6/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_3/loss_6/clip_by_value_grad/Reshape_1
|
+gradients_3/loss_6/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_3/loss_6/Sum_2_grad/ReshapeReshape8gradients_3/loss_6/mul_1_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_2_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
m
#gradients_3/loss_6/Sum_2_grad/ShapeShape
loss_6/pow*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_3/loss_6/Sum_2_grad/TileTile%gradients_3/loss_6/Sum_2_grad/Reshape#gradients_3/loss_6/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_3/loss_6/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_3/loss_6/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/mul_2_grad/Shape%gradients_3/loss_6/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_3/loss_6/mul_2_grad/mulMul6gradients_3/loss_6/add_1_grad/tuple/control_dependencyloss_6/Sum_3*
_output_shapes
: *
T0
ј
!gradients_3/loss_6/mul_2_grad/SumSum!gradients_3/loss_6/mul_2_grad/mul3gradients_3/loss_6/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/mul_2_grad/ReshapeReshape!gradients_3/loss_6/mul_2_grad/Sum#gradients_3/loss_6/mul_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_3/loss_6/mul_2_grad/mul_1Mulloss_6/mul_2/x6gradients_3/loss_6/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_3/loss_6/mul_2_grad/Sum_1Sum#gradients_3/loss_6/mul_2_grad/mul_15gradients_3/loss_6/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/mul_2_grad/Reshape_1Reshape#gradients_3/loss_6/mul_2_grad/Sum_1%gradients_3/loss_6/mul_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/mul_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/mul_2_grad/Reshape(^gradients_3/loss_6/mul_2_grad/Reshape_1
х
6gradients_3/loss_6/mul_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/mul_2_grad/Reshape/^gradients_3/loss_6/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_2_grad/Reshape
ы
8gradients_3/loss_6/mul_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/mul_2_grad/Reshape_1/^gradients_3/loss_6/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/mul_2_grad/Reshape_1
u
+gradients_3/loss_6/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_3/loss_6/Sum_4_grad/ReshapeReshape8gradients_3/loss_6/add_1_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_4_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_3/loss_6/Sum_4_grad/ShapeShapeloss_6/pow_2*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_3/loss_6/Sum_4_grad/TileTile%gradients_3/loss_6/Sum_4_grad/Reshape#gradients_3/loss_6/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_3/loss_6/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_3/loss_6/Sum_5_grad/ReshapeReshape8gradients_3/loss_6/mul_3_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_5_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_3/loss_6/Sum_5_grad/ShapeShapeloss_6/pow_3*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_3/loss_6/Sum_5_grad/TileTile%gradients_3/loss_6/Sum_5_grad/Reshape#gradients_3/loss_6/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_3/loss_6/pow_4_grad/ShapeShapeloss_6/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_4_grad/Shape%gradients_3/loss_6/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_3/loss_6/pow_4_grad/mulMul"gradients_3/loss_6/Sum_6_grad/Tileloss_6/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_3/loss_6/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_4_grad/subSubloss_6/pow_4/y#gradients_3/loss_6/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_4_grad/PowPowloss_6/neg_item_bias!gradients_3/loss_6/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_3/loss_6/pow_4_grad/mul_1Mul!gradients_3/loss_6/pow_4_grad/mul!gradients_3/loss_6/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_3/loss_6/pow_4_grad/SumSum#gradients_3/loss_6/pow_4_grad/mul_13gradients_3/loss_6/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/pow_4_grad/ReshapeReshape!gradients_3/loss_6/pow_4_grad/Sum#gradients_3/loss_6/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_3/loss_6/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_4_grad/GreaterGreaterloss_6/neg_item_bias'gradients_3/loss_6/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_3/loss_6/pow_4_grad/LogLogloss_6/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_3/loss_6/pow_4_grad/zeros_like	ZerosLikeloss_6/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_3/loss_6/pow_4_grad/SelectSelect%gradients_3/loss_6/pow_4_grad/Greater!gradients_3/loss_6/pow_4_grad/Log(gradients_3/loss_6/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_3/loss_6/pow_4_grad/mul_2Mul"gradients_3/loss_6/Sum_6_grad/Tileloss_6/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_3/loss_6/pow_4_grad/mul_3Mul#gradients_3/loss_6/pow_4_grad/mul_2$gradients_3/loss_6/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_3/loss_6/pow_4_grad/Sum_1Sum#gradients_3/loss_6/pow_4_grad/mul_35gradients_3/loss_6/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_4_grad/Reshape_1Reshape#gradients_3/loss_6/pow_4_grad/Sum_1%gradients_3/loss_6/pow_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/pow_4_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_4_grad/Reshape(^gradients_3/loss_6/pow_4_grad/Reshape_1
В
6gradients_3/loss_6/pow_4_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_4_grad/Reshape/^gradients_3/loss_6/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_4_grad/Reshape
ы
8gradients_3/loss_6/pow_4_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_4_grad/Reshape_1/^gradients_3/loss_6/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_4_grad/Reshape_1
Б
3gradients_3/loss_6/clip_by_value/Minimum_grad/ShapeShapeloss_6/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_2Shape>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_3/loss_6/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_3/loss_6/clip_by_value/Minimum_grad/zerosFill5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_29gradients_3/loss_6/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_3/loss_6/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_6/Sigmoidloss_6/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_3/loss_6/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_3/loss_6/clip_by_value/Minimum_grad/Shape5gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_3/loss_6/clip_by_value/Minimum_grad/SelectSelect7gradients_3/loss_6/clip_by_value/Minimum_grad/LessEqual>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency3gradients_3/loss_6/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_3/loss_6/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_3/loss_6/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_3/loss_6/clip_by_value/Minimum_grad/Select_1Select8gradients_3/loss_6/clip_by_value/Minimum_grad/LogicalNot>gradients_3/loss_6/clip_by_value_grad/tuple/control_dependency3gradients_3/loss_6/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_3/loss_6/clip_by_value/Minimum_grad/SumSum4gradients_3/loss_6/clip_by_value/Minimum_grad/SelectCgradients_3/loss_6/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_3/loss_6/clip_by_value/Minimum_grad/ReshapeReshape1gradients_3/loss_6/clip_by_value/Minimum_grad/Sum3gradients_3/loss_6/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
щ
3gradients_3/loss_6/clip_by_value/Minimum_grad/Sum_1Sum6gradients_3/loss_6/clip_by_value/Minimum_grad/Select_1Egradients_3/loss_6/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_3/loss_6/clip_by_value/Minimum_grad/Sum_15gradients_3/loss_6/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
Є
>gradients_3/loss_6/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape8^gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_3/loss_6/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape?^gradients_3/loss_6/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_3/loss_6/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1?^gradients_3/loss_6/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_3/loss_6/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_3/loss_6/pow_grad/ShapeShapeloss_6/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_3/loss_6/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_3/loss_6/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/pow_grad/Shape#gradients_3/loss_6/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_3/loss_6/pow_grad/mulMul"gradients_3/loss_6/Sum_2_grad/Tileloss_6/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_3/loss_6/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_3/loss_6/pow_grad/subSubloss_6/pow/y!gradients_3/loss_6/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_3/loss_6/pow_grad/PowPowloss_6/usersgradients_3/loss_6/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_3/loss_6/pow_grad/mul_1Mulgradients_3/loss_6/pow_grad/mulgradients_3/loss_6/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_3/loss_6/pow_grad/SumSum!gradients_3/loss_6/pow_grad/mul_11gradients_3/loss_6/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_3/loss_6/pow_grad/ReshapeReshapegradients_3/loss_6/pow_grad/Sum!gradients_3/loss_6/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
j
%gradients_3/loss_6/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_3/loss_6/pow_grad/GreaterGreaterloss_6/users%gradients_3/loss_6/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_3/loss_6/pow_grad/LogLogloss_6/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_3/loss_6/pow_grad/zeros_like	ZerosLikeloss_6/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_3/loss_6/pow_grad/SelectSelect#gradients_3/loss_6/pow_grad/Greatergradients_3/loss_6/pow_grad/Log&gradients_3/loss_6/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_3/loss_6/pow_grad/mul_2Mul"gradients_3/loss_6/Sum_2_grad/Tile
loss_6/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_3/loss_6/pow_grad/mul_3Mul!gradients_3/loss_6/pow_grad/mul_2"gradients_3/loss_6/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_3/loss_6/pow_grad/Sum_1Sum!gradients_3/loss_6/pow_grad/mul_33gradients_3/loss_6/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_3/loss_6/pow_grad/Reshape_1Reshape!gradients_3/loss_6/pow_grad/Sum_1#gradients_3/loss_6/pow_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
В
,gradients_3/loss_6/pow_grad/tuple/group_depsNoOp$^gradients_3/loss_6/pow_grad/Reshape&^gradients_3/loss_6/pow_grad/Reshape_1
ю
4gradients_3/loss_6/pow_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/pow_grad/Reshape-^gradients_3/loss_6/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_3/loss_6/pow_grad/Reshape
у
6gradients_3/loss_6/pow_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/pow_grad/Reshape_1-^gradients_3/loss_6/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_grad/Reshape_1
|
+gradients_3/loss_6/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_3/loss_6/Sum_3_grad/ReshapeReshape8gradients_3/loss_6/mul_2_grad/tuple/control_dependency_1+gradients_3/loss_6/Sum_3_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_3/loss_6/Sum_3_grad/ShapeShapeloss_6/pow_1*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_3/loss_6/Sum_3_grad/TileTile%gradients_3/loss_6/Sum_3_grad/Reshape#gradients_3/loss_6/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_3/loss_6/pow_2_grad/ShapeShapeloss_6/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_2_grad/Shape%gradients_3/loss_6/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_3/loss_6/pow_2_grad/mulMul"gradients_3/loss_6/Sum_4_grad/Tileloss_6/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_3/loss_6/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_2_grad/subSubloss_6/pow_2/y#gradients_3/loss_6/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_2_grad/PowPowloss_6/pos_item_bias!gradients_3/loss_6/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_3/loss_6/pow_2_grad/mul_1Mul!gradients_3/loss_6/pow_2_grad/mul!gradients_3/loss_6/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_3/loss_6/pow_2_grad/SumSum#gradients_3/loss_6/pow_2_grad/mul_13gradients_3/loss_6/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/pow_2_grad/ReshapeReshape!gradients_3/loss_6/pow_2_grad/Sum#gradients_3/loss_6/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_3/loss_6/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_2_grad/GreaterGreaterloss_6/pos_item_bias'gradients_3/loss_6/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_3/loss_6/pow_2_grad/LogLogloss_6/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_3/loss_6/pow_2_grad/zeros_like	ZerosLikeloss_6/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_3/loss_6/pow_2_grad/SelectSelect%gradients_3/loss_6/pow_2_grad/Greater!gradients_3/loss_6/pow_2_grad/Log(gradients_3/loss_6/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_3/loss_6/pow_2_grad/mul_2Mul"gradients_3/loss_6/Sum_4_grad/Tileloss_6/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_3/loss_6/pow_2_grad/mul_3Mul#gradients_3/loss_6/pow_2_grad/mul_2$gradients_3/loss_6/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_3/loss_6/pow_2_grad/Sum_1Sum#gradients_3/loss_6/pow_2_grad/mul_35gradients_3/loss_6/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_2_grad/Reshape_1Reshape#gradients_3/loss_6/pow_2_grad/Sum_1%gradients_3/loss_6/pow_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/pow_2_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_2_grad/Reshape(^gradients_3/loss_6/pow_2_grad/Reshape_1
В
6gradients_3/loss_6/pow_2_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_2_grad/Reshape/^gradients_3/loss_6/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_2_grad/Reshape
ы
8gradients_3/loss_6/pow_2_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_2_grad/Reshape_1/^gradients_3/loss_6/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_2_grad/Reshape_1
s
#gradients_3/loss_6/pow_3_grad/ShapeShapeloss_6/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_3_grad/Shape%gradients_3/loss_6/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_3/loss_6/pow_3_grad/mulMul"gradients_3/loss_6/Sum_5_grad/Tileloss_6/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_3/loss_6/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_3_grad/subSubloss_6/pow_3/y#gradients_3/loss_6/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_3_grad/PowPowloss_6/neg_items!gradients_3/loss_6/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_3/loss_6/pow_3_grad/mul_1Mul!gradients_3/loss_6/pow_3_grad/mul!gradients_3/loss_6/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_3/loss_6/pow_3_grad/SumSum#gradients_3/loss_6/pow_3_grad/mul_13gradients_3/loss_6/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_3/loss_6/pow_3_grad/ReshapeReshape!gradients_3/loss_6/pow_3_grad/Sum#gradients_3/loss_6/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_3/loss_6/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_3_grad/GreaterGreaterloss_6/neg_items'gradients_3/loss_6/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_3/loss_6/pow_3_grad/LogLogloss_6/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_3/loss_6/pow_3_grad/zeros_like	ZerosLikeloss_6/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_3/loss_6/pow_3_grad/SelectSelect%gradients_3/loss_6/pow_3_grad/Greater!gradients_3/loss_6/pow_3_grad/Log(gradients_3/loss_6/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_3/loss_6/pow_3_grad/mul_2Mul"gradients_3/loss_6/Sum_5_grad/Tileloss_6/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_3/loss_6/pow_3_grad/mul_3Mul#gradients_3/loss_6/pow_3_grad/mul_2$gradients_3/loss_6/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_3/loss_6/pow_3_grad/Sum_1Sum#gradients_3/loss_6/pow_3_grad/mul_35gradients_3/loss_6/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_3_grad/Reshape_1Reshape#gradients_3/loss_6/pow_3_grad/Sum_1%gradients_3/loss_6/pow_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/pow_3_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_3_grad/Reshape(^gradients_3/loss_6/pow_3_grad/Reshape_1
Ж
6gradients_3/loss_6/pow_3_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_3_grad/Reshape/^gradients_3/loss_6/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_3_grad/Reshape
ы
8gradients_3/loss_6/pow_3_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_3_grad/Reshape_1/^gradients_3/loss_6/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_3_grad/Reshape_1
ј
+gradients_3/loss_6/Sigmoid_grad/SigmoidGradSigmoidGradloss_6/SigmoidFgradients_3/loss_6/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_3/loss_6/pow_1_grad/ShapeShapeloss_6/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_3/loss_6/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_3/loss_6/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/pow_1_grad/Shape%gradients_3/loss_6/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_3/loss_6/pow_1_grad/mulMul"gradients_3/loss_6/Sum_3_grad/Tileloss_6/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_3/loss_6/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_3/loss_6/pow_1_grad/subSubloss_6/pow_1/y#gradients_3/loss_6/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_3/loss_6/pow_1_grad/PowPowloss_6/pos_items!gradients_3/loss_6/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_3/loss_6/pow_1_grad/mul_1Mul!gradients_3/loss_6/pow_1_grad/mul!gradients_3/loss_6/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_3/loss_6/pow_1_grad/SumSum#gradients_3/loss_6/pow_1_grad/mul_13gradients_3/loss_6/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_3/loss_6/pow_1_grad/ReshapeReshape!gradients_3/loss_6/pow_1_grad/Sum#gradients_3/loss_6/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_3/loss_6/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_3/loss_6/pow_1_grad/GreaterGreaterloss_6/pos_items'gradients_3/loss_6/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_3/loss_6/pow_1_grad/LogLogloss_6/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_3/loss_6/pow_1_grad/zeros_like	ZerosLikeloss_6/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_3/loss_6/pow_1_grad/SelectSelect%gradients_3/loss_6/pow_1_grad/Greater!gradients_3/loss_6/pow_1_grad/Log(gradients_3/loss_6/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_3/loss_6/pow_1_grad/mul_2Mul"gradients_3/loss_6/Sum_3_grad/Tileloss_6/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_3/loss_6/pow_1_grad/mul_3Mul#gradients_3/loss_6/pow_1_grad/mul_2$gradients_3/loss_6/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_3/loss_6/pow_1_grad/Sum_1Sum#gradients_3/loss_6/pow_1_grad/mul_35gradients_3/loss_6/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_3/loss_6/pow_1_grad/Reshape_1Reshape#gradients_3/loss_6/pow_1_grad/Sum_1%gradients_3/loss_6/pow_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_3/loss_6/pow_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/pow_1_grad/Reshape(^gradients_3/loss_6/pow_1_grad/Reshape_1
Ж
6gradients_3/loss_6/pow_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/pow_1_grad/Reshape/^gradients_3/loss_6/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/pow_1_grad/Reshape
ы
8gradients_3/loss_6/pow_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/pow_1_grad/Reshape_1/^gradients_3/loss_6/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_3/loss_6/pow_1_grad/Reshape_1
m
!gradients_3/loss_6/add_grad/ShapeShapeloss_6/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_3/loss_6/add_grad/Shape_1Shape
loss_6/Sum*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_3/loss_6/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/add_grad/Shape#gradients_3/loss_6/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_3/loss_6/add_grad/SumSum+gradients_3/loss_6/Sigmoid_grad/SigmoidGrad1gradients_3/loss_6/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_3/loss_6/add_grad/ReshapeReshapegradients_3/loss_6/add_grad/Sum!gradients_3/loss_6/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
!gradients_3/loss_6/add_grad/Sum_1Sum+gradients_3/loss_6/Sigmoid_grad/SigmoidGrad3gradients_3/loss_6/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/add_grad/Reshape_1Reshape!gradients_3/loss_6/add_grad/Sum_1#gradients_3/loss_6/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
В
,gradients_3/loss_6/add_grad/tuple/group_depsNoOp$^gradients_3/loss_6/add_grad/Reshape&^gradients_3/loss_6/add_grad/Reshape_1
ъ
4gradients_3/loss_6/add_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/add_grad/Reshape-^gradients_3/loss_6/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_3/loss_6/add_grad/Reshape
А
6gradients_3/loss_6/add_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/add_grad/Reshape_1-^gradients_3/loss_6/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/add_grad/Reshape_1
w
#gradients_3/loss_6/sub_1_grad/ShapeShapeloss_6/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_3/loss_6/sub_1_grad/Shape_1Shapeloss_6/neg_item_bias*
_output_shapes
:*
T0*
out_type0
’
3gradients_3/loss_6/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_3/loss_6/sub_1_grad/Shape%gradients_3/loss_6/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_3/loss_6/sub_1_grad/SumSum4gradients_3/loss_6/add_grad/tuple/control_dependency3gradients_3/loss_6/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_3/loss_6/sub_1_grad/ReshapeReshape!gradients_3/loss_6/sub_1_grad/Sum#gradients_3/loss_6/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
„
#gradients_3/loss_6/sub_1_grad/Sum_1Sum4gradients_3/loss_6/add_grad/tuple/control_dependency5gradients_3/loss_6/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_3/loss_6/sub_1_grad/NegNeg#gradients_3/loss_6/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_3/loss_6/sub_1_grad/Reshape_1Reshape!gradients_3/loss_6/sub_1_grad/Neg%gradients_3/loss_6/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
И
.gradients_3/loss_6/sub_1_grad/tuple/group_depsNoOp&^gradients_3/loss_6/sub_1_grad/Reshape(^gradients_3/loss_6/sub_1_grad/Reshape_1
В
6gradients_3/loss_6/sub_1_grad/tuple/control_dependencyIdentity%gradients_3/loss_6/sub_1_grad/Reshape/^gradients_3/loss_6/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_3/loss_6/sub_1_grad/Reshape
И
8gradients_3/loss_6/sub_1_grad/tuple/control_dependency_1Identity'gradients_3/loss_6/sub_1_grad/Reshape_1/^gradients_3/loss_6/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*:
_class0
.,loc:@gradients_3/loss_6/sub_1_grad/Reshape_1
k
!gradients_3/loss_6/Sum_grad/ShapeShape
loss_6/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_3/loss_6/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_3/loss_6/Sum_grad/addAddloss_6/Sum/reduction_indices gradients_3/loss_6/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_3/loss_6/Sum_grad/modFloorModgradients_3/loss_6/Sum_grad/add gradients_3/loss_6/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_3/loss_6/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_3/loss_6/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_3/loss_6/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_3/loss_6/Sum_grad/rangeRange'gradients_3/loss_6/Sum_grad/range/start gradients_3/loss_6/Sum_grad/Size'gradients_3/loss_6/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_3/loss_6/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_3/loss_6/Sum_grad/FillFill#gradients_3/loss_6/Sum_grad/Shape_1&gradients_3/loss_6/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_3/loss_6/Sum_grad/DynamicStitchDynamicStitch!gradients_3/loss_6/Sum_grad/rangegradients_3/loss_6/Sum_grad/mod!gradients_3/loss_6/Sum_grad/Shape gradients_3/loss_6/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
T0*
N
g
%gradients_3/loss_6/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_3/loss_6/Sum_grad/MaximumMaximum)gradients_3/loss_6/Sum_grad/DynamicStitch%gradients_3/loss_6/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_3/loss_6/Sum_grad/floordivFloorDiv!gradients_3/loss_6/Sum_grad/Shape#gradients_3/loss_6/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_3/loss_6/Sum_grad/ReshapeReshape6gradients_3/loss_6/add_grad/tuple/control_dependency_1)gradients_3/loss_6/Sum_grad/DynamicStitch*
_output_shapes
:*
Tshape0*
T0
Ј
 gradients_3/loss_6/Sum_grad/TileTile#gradients_3/loss_6/Sum_grad/Reshape$gradients_3/loss_6/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_3/AddNAddN6gradients_3/loss_6/pow_2_grad/tuple/control_dependency6gradients_3/loss_6/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_3/loss_6/pow_2_grad/Reshape
†
+gradients_3/loss_6/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_3/item_bias
Е
*gradients_3/loss_6/pos_item_bias_grad/SizeSize placeholders_3/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_3/loss_6/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_3/loss_6/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_3/loss_6/pos_item_bias_grad/Size4gradients_3/loss_6/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_3/loss_6/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_3/loss_6/pos_item_bias_grad/strided_sliceStridedSlice+gradients_3/loss_6/pos_item_bias_grad/Shape9gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_1;gradients_3/loss_6/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_3/loss_6/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_3/loss_6/pos_item_bias_grad/concatConcatV20gradients_3/loss_6/pos_item_bias_grad/ExpandDims3gradients_3/loss_6/pos_item_bias_grad/strided_slice1gradients_3/loss_6/pos_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
і
-gradients_3/loss_6/pos_item_bias_grad/ReshapeReshapegradients_3/AddN,gradients_3/loss_6/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_3/loss_6/pos_item_bias_grad/Reshape_1Reshape placeholders_3/sampled_pos_items0gradients_3/loss_6/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
э
gradients_3/AddN_1AddN6gradients_3/loss_6/pow_4_grad/tuple/control_dependency8gradients_3/loss_6/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_3/loss_6/pow_4_grad/Reshape
†
+gradients_3/loss_6/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_3/item_bias
Е
*gradients_3/loss_6/neg_item_bias_grad/SizeSize placeholders_3/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_3/loss_6/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_3/loss_6/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_3/loss_6/neg_item_bias_grad/Size4gradients_3/loss_6/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_3/loss_6/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_3/loss_6/neg_item_bias_grad/strided_sliceStridedSlice+gradients_3/loss_6/neg_item_bias_grad/Shape9gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_1;gradients_3/loss_6/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_3/loss_6/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_3/loss_6/neg_item_bias_grad/concatConcatV20gradients_3/loss_6/neg_item_bias_grad/ExpandDims3gradients_3/loss_6/neg_item_bias_grad/strided_slice1gradients_3/loss_6/neg_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ґ
-gradients_3/loss_6/neg_item_bias_grad/ReshapeReshapegradients_3/AddN_1,gradients_3/loss_6/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_3/loss_6/neg_item_bias_grad/Reshape_1Reshape placeholders_3/sampled_neg_items0gradients_3/loss_6/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
m
!gradients_3/loss_6/mul_grad/ShapeShapeloss_6/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_3/loss_6/mul_grad/Shape_1Shape
loss_6/sub*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_3/loss_6/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/mul_grad/Shape#gradients_3/loss_6/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_3/loss_6/mul_grad/mulMul gradients_3/loss_6/Sum_grad/Tile
loss_6/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_3/loss_6/mul_grad/SumSumgradients_3/loss_6/mul_grad/mul1gradients_3/loss_6/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_3/loss_6/mul_grad/ReshapeReshapegradients_3/loss_6/mul_grad/Sum!gradients_3/loss_6/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
К
!gradients_3/loss_6/mul_grad/mul_1Mulloss_6/users gradients_3/loss_6/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_3/loss_6/mul_grad/Sum_1Sum!gradients_3/loss_6/mul_grad/mul_13gradients_3/loss_6/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_3/loss_6/mul_grad/Reshape_1Reshape!gradients_3/loss_6/mul_grad/Sum_1#gradients_3/loss_6/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_3/loss_6/mul_grad/tuple/group_depsNoOp$^gradients_3/loss_6/mul_grad/Reshape&^gradients_3/loss_6/mul_grad/Reshape_1
ю
4gradients_3/loss_6/mul_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/mul_grad/Reshape-^gradients_3/loss_6/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_3/loss_6/mul_grad/Reshape
Д
6gradients_3/loss_6/mul_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/mul_grad/Reshape_1-^gradients_3/loss_6/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/mul_grad/Reshape_1
Y
gradients_3/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_3/concatConcatV2-gradients_3/loss_6/pos_item_bias_grad/Reshape-gradients_3/loss_6/neg_item_bias_grad/Reshapegradients_3/concat/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_3/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_3/concat_1ConcatV2/gradients_3/loss_6/pos_item_bias_grad/Reshape_1/gradients_3/loss_6/neg_item_bias_grad/Reshape_1gradients_3/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
щ
gradients_3/AddN_2AddN4gradients_3/loss_6/pow_grad/tuple/control_dependency4gradients_3/loss_6/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*6
_class,
*(loc:@gradients_3/loss_6/pow_grad/Reshape
°
#gradients_3/loss_6/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_3/user_factors
y
"gradients_3/loss_6/users_grad/SizeSizeplaceholders_3/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_3/loss_6/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_3/loss_6/users_grad/ExpandDims
ExpandDims"gradients_3/loss_6/users_grad/Size,gradients_3/loss_6/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_3/loss_6/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_3/loss_6/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_3/loss_6/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_3/loss_6/users_grad/strided_sliceStridedSlice#gradients_3/loss_6/users_grad/Shape1gradients_3/loss_6/users_grad/strided_slice/stack3gradients_3/loss_6/users_grad/strided_slice/stack_13gradients_3/loss_6/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_3/loss_6/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_3/loss_6/users_grad/concatConcatV2(gradients_3/loss_6/users_grad/ExpandDims+gradients_3/loss_6/users_grad/strided_slice)gradients_3/loss_6/users_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
≥
%gradients_3/loss_6/users_grad/ReshapeReshapegradients_3/AddN_2$gradients_3/loss_6/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
ґ
'gradients_3/loss_6/users_grad/Reshape_1Reshapeplaceholders_3/sampled_users(gradients_3/loss_6/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
q
!gradients_3/loss_6/sub_grad/ShapeShapeloss_6/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_3/loss_6/sub_grad/Shape_1Shapeloss_6/neg_items*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_3/loss_6/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_3/loss_6/sub_grad/Shape#gradients_3/loss_6/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_3/loss_6/sub_grad/SumSum6gradients_3/loss_6/mul_grad/tuple/control_dependency_11gradients_3/loss_6/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_3/loss_6/sub_grad/ReshapeReshapegradients_3/loss_6/sub_grad/Sum!gradients_3/loss_6/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
’
!gradients_3/loss_6/sub_grad/Sum_1Sum6gradients_3/loss_6/mul_grad/tuple/control_dependency_13gradients_3/loss_6/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_3/loss_6/sub_grad/NegNeg!gradients_3/loss_6/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_3/loss_6/sub_grad/Reshape_1Reshapegradients_3/loss_6/sub_grad/Neg#gradients_3/loss_6/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_3/loss_6/sub_grad/tuple/group_depsNoOp$^gradients_3/loss_6/sub_grad/Reshape&^gradients_3/loss_6/sub_grad/Reshape_1
ю
4gradients_3/loss_6/sub_grad/tuple/control_dependencyIdentity#gradients_3/loss_6/sub_grad/Reshape-^gradients_3/loss_6/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_3/loss_6/sub_grad/Reshape
Д
6gradients_3/loss_6/sub_grad/tuple/control_dependency_1Identity%gradients_3/loss_6/sub_grad/Reshape_1-^gradients_3/loss_6/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_3/loss_6/sub_grad/Reshape_1
э
gradients_3/AddN_3AddN6gradients_3/loss_6/pow_1_grad/tuple/control_dependency4gradients_3/loss_6/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_3/loss_6/pow_1_grad/Reshape
•
'gradients_3/loss_6/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_3/item_factors
Б
&gradients_3/loss_6/pos_items_grad/SizeSize placeholders_3/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_3/loss_6/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_3/loss_6/pos_items_grad/ExpandDims
ExpandDims&gradients_3/loss_6/pos_items_grad/Size0gradients_3/loss_6/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_3/loss_6/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_3/loss_6/pos_items_grad/strided_sliceStridedSlice'gradients_3/loss_6/pos_items_grad/Shape5gradients_3/loss_6/pos_items_grad/strided_slice/stack7gradients_3/loss_6/pos_items_grad/strided_slice/stack_17gradients_3/loss_6/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_3/loss_6/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_3/loss_6/pos_items_grad/concatConcatV2,gradients_3/loss_6/pos_items_grad/ExpandDims/gradients_3/loss_6/pos_items_grad/strided_slice-gradients_3/loss_6/pos_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_3/loss_6/pos_items_grad/ReshapeReshapegradients_3/AddN_3(gradients_3/loss_6/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_3/loss_6/pos_items_grad/Reshape_1Reshape placeholders_3/sampled_pos_items,gradients_3/loss_6/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
€
gradients_3/AddN_4AddN6gradients_3/loss_6/pow_3_grad/tuple/control_dependency6gradients_3/loss_6/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_3/loss_6/pow_3_grad/Reshape
•
'gradients_3/loss_6/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_3/item_factors
Б
&gradients_3/loss_6/neg_items_grad/SizeSize placeholders_3/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_3/loss_6/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_3/loss_6/neg_items_grad/ExpandDims
ExpandDims&gradients_3/loss_6/neg_items_grad/Size0gradients_3/loss_6/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_3/loss_6/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_3/loss_6/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_3/loss_6/neg_items_grad/strided_sliceStridedSlice'gradients_3/loss_6/neg_items_grad/Shape5gradients_3/loss_6/neg_items_grad/strided_slice/stack7gradients_3/loss_6/neg_items_grad/strided_slice/stack_17gradients_3/loss_6/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_3/loss_6/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_3/loss_6/neg_items_grad/concatConcatV2,gradients_3/loss_6/neg_items_grad/ExpandDims/gradients_3/loss_6/neg_items_grad/strided_slice-gradients_3/loss_6/neg_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_3/loss_6/neg_items_grad/ReshapeReshapegradients_3/AddN_4(gradients_3/loss_6/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_3/loss_6/neg_items_grad/Reshape_1Reshape placeholders_3/sampled_neg_items,gradients_3/loss_6/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
[
gradients_3/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_3/concat_2ConcatV2)gradients_3/loss_6/pos_items_grad/Reshape)gradients_3/loss_6/neg_items_grad/Reshapegradients_3/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_3/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_3/concat_3ConcatV2+gradients_3/loss_6/pos_items_grad/Reshape_1+gradients_3/loss_6/neg_items_grad/Reshape_1gradients_3/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
d
GradientDescent_3/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_3/update_variables_3/user_factors/mulMul%gradients_3/loss_6/users_grad/ReshapeGradientDescent_3/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_3/user_factors
Њ
<GradientDescent_3/update_variables_3/user_factors/ScatterSub
ScatterSubvariables_3/user_factors'gradients_3/loss_6/users_grad/Reshape_15GradientDescent_3/update_variables_3/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_3/user_factors
џ
5GradientDescent_3/update_variables_3/item_factors/mulMulgradients_3/concat_2GradientDescent_3/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_3/item_factors
Ђ
<GradientDescent_3/update_variables_3/item_factors/ScatterSub
ScatterSubvariables_3/item_factorsgradients_3/concat_35GradientDescent_3/update_variables_3/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_3/item_factors
∆
2GradientDescent_3/update_variables_3/item_bias/mulMulgradients_3/concatGradientDescent_3/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_3/item_bias
Ы
9GradientDescent_3/update_variables_3/item_bias/ScatterSub
ScatterSubvariables_3/item_biasgradients_3/concat_12GradientDescent_3/update_variables_3/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_3/item_bias
”
GradientDescent_3NoOp=^GradientDescent_3/update_variables_3/user_factors/ScatterSub=^GradientDescent_3/update_variables_3/item_factors/ScatterSub:^GradientDescent_3/update_variables_3/item_bias/ScatterSub
R
loss_7/tagsConst*
valueB Bloss_7*
_output_shapes
: *
dtype0
S
loss_7ScalarSummaryloss_7/tagsloss_6/sub_2*
_output_shapes
: *
T0
e
Merge_3/MergeSummaryMergeSummaryloss_1loss_3loss_5loss_7*
_output_shapes
: *
N
Ф
init_3NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign ^variables_2/user_factors/Assign ^variables_2/item_factors/Assign^variables_2/item_bias/Assign ^variables_3/user_factors/Assign ^variables_3/item_factors/Assign^variables_3/item_bias/Assign
j
placeholders_4/sampled_usersPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_4/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
n
 placeholders_4/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:€€€€€€€€€*
dtype0
s
"variables_4/truncated_normal/shapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0
f
!variables_4/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables_4/truncated_normal/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
Ј
,variables_4/truncated_normal/TruncatedNormalTruncatedNormal"variables_4/truncated_normal/shape*
seed2“	*
_output_shapes
:	д
*
dtype0*
T0*
seed±€е)
§
 variables_4/truncated_normal/mulMul,variables_4/truncated_normal/TruncatedNormal#variables_4/truncated_normal/stddev*
_output_shapes
:	д
*
T0
Т
variables_4/truncated_normalAdd variables_4/truncated_normal/mul!variables_4/truncated_normal/mean*
_output_shapes
:	д
*
T0
u
$variables_4/truncated_normal_1/shapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0
h
#variables_4/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
j
%variables_4/truncated_normal_1/stddevConst*
valueB
 *Ыи°>*
_output_shapes
: *
dtype0
ї
.variables_4/truncated_normal_1/TruncatedNormalTruncatedNormal$variables_4/truncated_normal_1/shape*
seed2“	*
_output_shapes
:	з
*
dtype0*
T0*
seed±€е)
™
"variables_4/truncated_normal_1/mulMul.variables_4/truncated_normal_1/TruncatedNormal%variables_4/truncated_normal_1/stddev*
_output_shapes
:	з
*
T0
Ш
variables_4/truncated_normal_1Add"variables_4/truncated_normal_1/mul#variables_4/truncated_normal_1/mean*
_output_shapes
:	з
*
T0
О
variables_4/user_factors
VariableV2*
shape:	д
*
_output_shapes
:	д
*
dtype0*
	container *
shared_name 
б
variables_4/user_factors/AssignAssignvariables_4/user_factorsvariables_4/truncated_normal*
validate_shape(*
use_locking(*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_4/user_factors
Ъ
variables_4/user_factors/readIdentityvariables_4/user_factors*
_output_shapes
:	д
*
T0*+
_class!
loc:@variables_4/user_factors
О
variables_4/item_factors
VariableV2*
shape:	з
*
_output_shapes
:	з
*
dtype0*
	container *
shared_name 
г
variables_4/item_factors/AssignAssignvariables_4/item_factorsvariables_4/truncated_normal_1*
validate_shape(*
use_locking(*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_4/item_factors
Ъ
variables_4/item_factors/readIdentityvariables_4/item_factors*
_output_shapes
:	з
*
T0*+
_class!
loc:@variables_4/item_factors
`
variables_4/zerosConst*
valueBз*    *
_output_shapes	
:з*
dtype0
Г
variables_4/item_bias
VariableV2*
shape:з*
_output_shapes	
:з*
dtype0*
	container *
shared_name 
…
variables_4/item_bias/AssignAssignvariables_4/item_biasvariables_4/zeros*
validate_shape(*
use_locking(*
_output_shapes	
:з*
T0*(
_class
loc:@variables_4/item_bias
Н
variables_4/item_bias/readIdentityvariables_4/item_bias*
_output_shapes	
:з*
T0*(
_class
loc:@variables_4/item_bias
≥
loss_8/usersGathervariables_4/user_factors/readplaceholders_4/sampled_users*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_8/pos_itemsGathervariables_4/item_factors/read placeholders_4/sampled_pos_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
ї
loss_8/neg_itemsGathervariables_4/item_factors/read placeholders_4/sampled_neg_items*
Tparams0*
validate_indices(*'
_output_shapes
:€€€€€€€€€
*
Tindices0
Є
loss_8/pos_item_biasGathervariables_4/item_bias/read placeholders_4/sampled_pos_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
Є
loss_8/neg_item_biasGathervariables_4/item_bias/read placeholders_4/sampled_neg_items*
Tparams0*
validate_indices(*#
_output_shapes
:€€€€€€€€€*
Tindices0
g

loss_8/subSubloss_8/pos_itemsloss_8/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
]

loss_8/mulMulloss_8/users
loss_8/sub*'
_output_shapes
:€€€€€€€€€
*
T0
^
loss_8/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0
Ж

loss_8/SumSum
loss_8/mulloss_8/Sum/reduction_indices*#
_output_shapes
:€€€€€€€€€*
	keep_dims( *
T0*

Tidx0
m
loss_8/sub_1Subloss_8/pos_item_biasloss_8/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
Y

loss_8/addAddloss_8/sub_1
loss_8/Sum*#
_output_shapes
:€€€€€€€€€*
T0
S
loss_8/SigmoidSigmoid
loss_8/add*#
_output_shapes
:€€€€€€€€€*
T0
c
loss_8/clip_by_value/Minimum/yConst*
valueB
 *§p}?*
_output_shapes
: *
dtype0
Е
loss_8/clip_by_value/MinimumMinimumloss_8/Sigmoidloss_8/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
[
loss_8/clip_by_value/yConst*
valueB
 *ђ≈'7*
_output_shapes
: *
dtype0
Г
loss_8/clip_by_valueMaximumloss_8/clip_by_value/Minimumloss_8/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
U

loss_8/LogLogloss_8/clip_by_value*#
_output_shapes
:€€€€€€€€€*
T0
V
loss_8/ConstConst*
valueB: *
_output_shapes
:*
dtype0
k
loss_8/Sum_1Sum
loss_8/Logloss_8/Const*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
Q
loss_8/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
_

loss_8/powPowloss_8/usersloss_8/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_8/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
m
loss_8/Sum_2Sum
loss_8/powloss_8/Const_1*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_8/mul_1/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_8/mul_1Mulloss_8/mul_1/xloss_8/Sum_2*
_output_shapes
: *
T0
S
loss_8/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_1Powloss_8/pos_itemsloss_8/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_8/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_8/Sum_3Sumloss_8/pow_1loss_8/Const_2*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_8/mul_2/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_8/mul_2Mulloss_8/mul_2/xloss_8/Sum_3*
_output_shapes
: *
T0
S
loss_8/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_2Powloss_8/pos_item_biasloss_8/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_8/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_8/Sum_4Sumloss_8/pow_2loss_8/Const_3*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_8/add_1Addloss_8/mul_2loss_8/Sum_4*
_output_shapes
: *
T0
S
loss_8/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_3Powloss_8/neg_itemsloss_8/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
_
loss_8/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
o
loss_8/Sum_5Sumloss_8/pow_3loss_8/Const_4*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
S
loss_8/mul_3/xConst*
valueB
 *
„#<*
_output_shapes
: *
dtype0
R
loss_8/mul_3Mulloss_8/mul_3/xloss_8/Sum_5*
_output_shapes
: *
T0
S
loss_8/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
g
loss_8/pow_4Powloss_8/neg_item_biasloss_8/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
X
loss_8/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
o
loss_8/Sum_6Sumloss_8/pow_4loss_8/Const_5*
_output_shapes
: *
	keep_dims( *
T0*

Tidx0
P
loss_8/add_2Addloss_8/mul_3loss_8/Sum_6*
_output_shapes
: *
T0
P
loss_8/add_3Addloss_8/mul_1loss_8/add_1*
_output_shapes
: *
T0
P
loss_8/add_4Addloss_8/add_3loss_8/add_2*
_output_shapes
: *
T0
P
loss_8/sub_2Subloss_8/add_4loss_8/Sum_1*
_output_shapes
: *
T0
T
gradients_4/ShapeConst*
valueB *
_output_shapes
: *
dtype0
V
gradients_4/ConstConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
_
gradients_4/FillFillgradients_4/Shapegradients_4/Const*
_output_shapes
: *
T0
f
#gradients_4/loss_8/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/sub_2_grad/Shape%gradients_4/loss_8/sub_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ѓ
!gradients_4/loss_8/sub_2_grad/SumSumgradients_4/Fill3gradients_4/loss_8/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/sub_2_grad/ReshapeReshape!gradients_4/loss_8/sub_2_grad/Sum#gradients_4/loss_8/sub_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
≥
#gradients_4/loss_8/sub_2_grad/Sum_1Sumgradients_4/Fill5gradients_4/loss_8/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_4/loss_8/sub_2_grad/NegNeg#gradients_4/loss_8/sub_2_grad/Sum_1*
_output_shapes
:*
T0
Ђ
'gradients_4/loss_8/sub_2_grad/Reshape_1Reshape!gradients_4/loss_8/sub_2_grad/Neg%gradients_4/loss_8/sub_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/sub_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/sub_2_grad/Reshape(^gradients_4/loss_8/sub_2_grad/Reshape_1
х
6gradients_4/loss_8/sub_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/sub_2_grad/Reshape/^gradients_4/loss_8/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/sub_2_grad/Reshape
ы
8gradients_4/loss_8/sub_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/sub_2_grad/Reshape_1/^gradients_4/loss_8/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/sub_2_grad/Reshape_1
f
#gradients_4/loss_8/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_4_grad/Shape%gradients_4/loss_8/add_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_4/loss_8/add_4_grad/SumSum6gradients_4/loss_8/sub_2_grad/tuple/control_dependency3gradients_4/loss_8/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_4_grad/ReshapeReshape!gradients_4/loss_8/add_4_grad/Sum#gradients_4/loss_8/add_4_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_4/loss_8/add_4_grad/Sum_1Sum6gradients_4/loss_8/sub_2_grad/tuple/control_dependency5gradients_4/loss_8/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_4_grad/Reshape_1Reshape#gradients_4/loss_8/add_4_grad/Sum_1%gradients_4/loss_8/add_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/add_4_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_4_grad/Reshape(^gradients_4/loss_8/add_4_grad/Reshape_1
х
6gradients_4/loss_8/add_4_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_4_grad/Reshape/^gradients_4/loss_8/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_4_grad/Reshape
ы
8gradients_4/loss_8/add_4_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_4_grad/Reshape_1/^gradients_4/loss_8/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_4_grad/Reshape_1
u
+gradients_4/loss_8/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_4/loss_8/Sum_1_grad/ReshapeReshape8gradients_4/loss_8/sub_2_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_1_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
m
#gradients_4/loss_8/Sum_1_grad/ShapeShape
loss_8/Log*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_4/loss_8/Sum_1_grad/TileTile%gradients_4/loss_8/Sum_1_grad/Reshape#gradients_4/loss_8/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_4/loss_8/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_3_grad/Shape%gradients_4/loss_8/add_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
’
!gradients_4/loss_8/add_3_grad/SumSum6gradients_4/loss_8/add_4_grad/tuple/control_dependency3gradients_4/loss_8/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_3_grad/ReshapeReshape!gradients_4/loss_8/add_3_grad/Sum#gradients_4/loss_8/add_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
ў
#gradients_4/loss_8/add_3_grad/Sum_1Sum6gradients_4/loss_8/add_4_grad/tuple/control_dependency5gradients_4/loss_8/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_3_grad/Reshape_1Reshape#gradients_4/loss_8/add_3_grad/Sum_1%gradients_4/loss_8/add_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/add_3_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_3_grad/Reshape(^gradients_4/loss_8/add_3_grad/Reshape_1
х
6gradients_4/loss_8/add_3_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_3_grad/Reshape/^gradients_4/loss_8/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_3_grad/Reshape
ы
8gradients_4/loss_8/add_3_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_3_grad/Reshape_1/^gradients_4/loss_8/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_3_grad/Reshape_1
f
#gradients_4/loss_8/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_2_grad/Shape%gradients_4/loss_8/add_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_4/loss_8/add_2_grad/SumSum8gradients_4/loss_8/add_4_grad/tuple/control_dependency_13gradients_4/loss_8/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_2_grad/ReshapeReshape!gradients_4/loss_8/add_2_grad/Sum#gradients_4/loss_8/add_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_4/loss_8/add_2_grad/Sum_1Sum8gradients_4/loss_8/add_4_grad/tuple/control_dependency_15gradients_4/loss_8/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_2_grad/Reshape_1Reshape#gradients_4/loss_8/add_2_grad/Sum_1%gradients_4/loss_8/add_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/add_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_2_grad/Reshape(^gradients_4/loss_8/add_2_grad/Reshape_1
х
6gradients_4/loss_8/add_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_2_grad/Reshape/^gradients_4/loss_8/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_2_grad/Reshape
ы
8gradients_4/loss_8/add_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_2_grad/Reshape_1/^gradients_4/loss_8/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_2_grad/Reshape_1
Э
&gradients_4/loss_8/Log_grad/Reciprocal
Reciprocalloss_8/clip_by_value#^gradients_4/loss_8/Sum_1_grad/Tile*#
_output_shapes
:€€€€€€€€€*
T0
†
gradients_4/loss_8/Log_grad/mulMul"gradients_4/loss_8/Sum_1_grad/Tile&gradients_4/loss_8/Log_grad/Reciprocal*#
_output_shapes
:€€€€€€€€€*
T0
f
#gradients_4/loss_8/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/mul_1_grad/Shape%gradients_4/loss_8/mul_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_4/loss_8/mul_1_grad/mulMul6gradients_4/loss_8/add_3_grad/tuple/control_dependencyloss_8/Sum_2*
_output_shapes
: *
T0
ј
!gradients_4/loss_8/mul_1_grad/SumSum!gradients_4/loss_8/mul_1_grad/mul3gradients_4/loss_8/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/mul_1_grad/ReshapeReshape!gradients_4/loss_8/mul_1_grad/Sum#gradients_4/loss_8/mul_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_4/loss_8/mul_1_grad/mul_1Mulloss_8/mul_1/x6gradients_4/loss_8/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_4/loss_8/mul_1_grad/Sum_1Sum#gradients_4/loss_8/mul_1_grad/mul_15gradients_4/loss_8/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/mul_1_grad/Reshape_1Reshape#gradients_4/loss_8/mul_1_grad/Sum_1%gradients_4/loss_8/mul_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/mul_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/mul_1_grad/Reshape(^gradients_4/loss_8/mul_1_grad/Reshape_1
х
6gradients_4/loss_8/mul_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/mul_1_grad/Reshape/^gradients_4/loss_8/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_1_grad/Reshape
ы
8gradients_4/loss_8/mul_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/mul_1_grad/Reshape_1/^gradients_4/loss_8/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/mul_1_grad/Reshape_1
f
#gradients_4/loss_8/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/add_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/add_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/add_1_grad/Shape%gradients_4/loss_8/add_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
„
!gradients_4/loss_8/add_1_grad/SumSum8gradients_4/loss_8/add_3_grad/tuple/control_dependency_13gradients_4/loss_8/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/add_1_grad/ReshapeReshape!gradients_4/loss_8/add_1_grad/Sum#gradients_4/loss_8/add_1_grad/Shape*
_output_shapes
: *
Tshape0*
T0
џ
#gradients_4/loss_8/add_1_grad/Sum_1Sum8gradients_4/loss_8/add_3_grad/tuple/control_dependency_15gradients_4/loss_8/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/add_1_grad/Reshape_1Reshape#gradients_4/loss_8/add_1_grad/Sum_1%gradients_4/loss_8/add_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/add_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/add_1_grad/Reshape(^gradients_4/loss_8/add_1_grad/Reshape_1
х
6gradients_4/loss_8/add_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/add_1_grad/Reshape/^gradients_4/loss_8/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/add_1_grad/Reshape
ы
8gradients_4/loss_8/add_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/add_1_grad/Reshape_1/^gradients_4/loss_8/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/add_1_grad/Reshape_1
f
#gradients_4/loss_8/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/mul_3_grad/Shape%gradients_4/loss_8/mul_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_4/loss_8/mul_3_grad/mulMul6gradients_4/loss_8/add_2_grad/tuple/control_dependencyloss_8/Sum_5*
_output_shapes
: *
T0
ј
!gradients_4/loss_8/mul_3_grad/SumSum!gradients_4/loss_8/mul_3_grad/mul3gradients_4/loss_8/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/mul_3_grad/ReshapeReshape!gradients_4/loss_8/mul_3_grad/Sum#gradients_4/loss_8/mul_3_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_4/loss_8/mul_3_grad/mul_1Mulloss_8/mul_3/x6gradients_4/loss_8/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_4/loss_8/mul_3_grad/Sum_1Sum#gradients_4/loss_8/mul_3_grad/mul_15gradients_4/loss_8/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/mul_3_grad/Reshape_1Reshape#gradients_4/loss_8/mul_3_grad/Sum_1%gradients_4/loss_8/mul_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/mul_3_grad/tuple/group_depsNoOp&^gradients_4/loss_8/mul_3_grad/Reshape(^gradients_4/loss_8/mul_3_grad/Reshape_1
х
6gradients_4/loss_8/mul_3_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/mul_3_grad/Reshape/^gradients_4/loss_8/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_3_grad/Reshape
ы
8gradients_4/loss_8/mul_3_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/mul_3_grad/Reshape_1/^gradients_4/loss_8/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/mul_3_grad/Reshape_1
u
+gradients_4/loss_8/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_4/loss_8/Sum_6_grad/ReshapeReshape8gradients_4/loss_8/add_2_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_6_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_4/loss_8/Sum_6_grad/ShapeShapeloss_8/pow_4*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_4/loss_8/Sum_6_grad/TileTile%gradients_4/loss_8/Sum_6_grad/Reshape#gradients_4/loss_8/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
З
+gradients_4/loss_8/clip_by_value_grad/ShapeShapeloss_8/clip_by_value/Minimum*
_output_shapes
:*
T0*
out_type0
p
-gradients_4/loss_8/clip_by_value_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
М
-gradients_4/loss_8/clip_by_value_grad/Shape_2Shapegradients_4/loss_8/Log_grad/mul*
_output_shapes
:*
T0*
out_type0
v
1gradients_4/loss_8/clip_by_value_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
√
+gradients_4/loss_8/clip_by_value_grad/zerosFill-gradients_4/loss_8/clip_by_value_grad/Shape_21gradients_4/loss_8/clip_by_value_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
¶
2gradients_4/loss_8/clip_by_value_grad/GreaterEqualGreaterEqualloss_8/clip_by_value/Minimumloss_8/clip_by_value/y*#
_output_shapes
:€€€€€€€€€*
T0
н
;gradients_4/loss_8/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs+gradients_4/loss_8/clip_by_value_grad/Shape-gradients_4/loss_8/clip_by_value_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
ж
,gradients_4/loss_8/clip_by_value_grad/SelectSelect2gradients_4/loss_8/clip_by_value_grad/GreaterEqualgradients_4/loss_8/Log_grad/mul+gradients_4/loss_8/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
Ч
0gradients_4/loss_8/clip_by_value_grad/LogicalNot
LogicalNot2gradients_4/loss_8/clip_by_value_grad/GreaterEqual*#
_output_shapes
:€€€€€€€€€
ж
.gradients_4/loss_8/clip_by_value_grad/Select_1Select0gradients_4/loss_8/clip_by_value_grad/LogicalNotgradients_4/loss_8/Log_grad/mul+gradients_4/loss_8/clip_by_value_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
џ
)gradients_4/loss_8/clip_by_value_grad/SumSum,gradients_4/loss_8/clip_by_value_grad/Select;gradients_4/loss_8/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
ћ
-gradients_4/loss_8/clip_by_value_grad/ReshapeReshape)gradients_4/loss_8/clip_by_value_grad/Sum+gradients_4/loss_8/clip_by_value_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
б
+gradients_4/loss_8/clip_by_value_grad/Sum_1Sum.gradients_4/loss_8/clip_by_value_grad/Select_1=gradients_4/loss_8/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≈
/gradients_4/loss_8/clip_by_value_grad/Reshape_1Reshape+gradients_4/loss_8/clip_by_value_grad/Sum_1-gradients_4/loss_8/clip_by_value_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
†
6gradients_4/loss_8/clip_by_value_grad/tuple/group_depsNoOp.^gradients_4/loss_8/clip_by_value_grad/Reshape0^gradients_4/loss_8/clip_by_value_grad/Reshape_1
Ґ
>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependencyIdentity-gradients_4/loss_8/clip_by_value_grad/Reshape7^gradients_4/loss_8/clip_by_value_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*@
_class6
42loc:@gradients_4/loss_8/clip_by_value_grad/Reshape
Ы
@gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency_1Identity/gradients_4/loss_8/clip_by_value_grad/Reshape_17^gradients_4/loss_8/clip_by_value_grad/tuple/group_deps*
_output_shapes
: *
T0*B
_class8
64loc:@gradients_4/loss_8/clip_by_value_grad/Reshape_1
|
+gradients_4/loss_8/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_4/loss_8/Sum_2_grad/ReshapeReshape8gradients_4/loss_8/mul_1_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_2_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
m
#gradients_4/loss_8/Sum_2_grad/ShapeShape
loss_8/pow*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_4/loss_8/Sum_2_grad/TileTile%gradients_4/loss_8/Sum_2_grad/Reshape#gradients_4/loss_8/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
f
#gradients_4/loss_8/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
h
%gradients_4/loss_8/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/mul_2_grad/Shape%gradients_4/loss_8/mul_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
П
!gradients_4/loss_8/mul_2_grad/mulMul6gradients_4/loss_8/add_1_grad/tuple/control_dependencyloss_8/Sum_3*
_output_shapes
: *
T0
ј
!gradients_4/loss_8/mul_2_grad/SumSum!gradients_4/loss_8/mul_2_grad/mul3gradients_4/loss_8/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/mul_2_grad/ReshapeReshape!gradients_4/loss_8/mul_2_grad/Sum#gradients_4/loss_8/mul_2_grad/Shape*
_output_shapes
: *
Tshape0*
T0
У
#gradients_4/loss_8/mul_2_grad/mul_1Mulloss_8/mul_2/x6gradients_4/loss_8/add_1_grad/tuple/control_dependency*
_output_shapes
: *
T0
∆
#gradients_4/loss_8/mul_2_grad/Sum_1Sum#gradients_4/loss_8/mul_2_grad/mul_15gradients_4/loss_8/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/mul_2_grad/Reshape_1Reshape#gradients_4/loss_8/mul_2_grad/Sum_1%gradients_4/loss_8/mul_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/mul_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/mul_2_grad/Reshape(^gradients_4/loss_8/mul_2_grad/Reshape_1
х
6gradients_4/loss_8/mul_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/mul_2_grad/Reshape/^gradients_4/loss_8/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_2_grad/Reshape
ы
8gradients_4/loss_8/mul_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/mul_2_grad/Reshape_1/^gradients_4/loss_8/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/mul_2_grad/Reshape_1
u
+gradients_4/loss_8/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
 
%gradients_4/loss_8/Sum_4_grad/ReshapeReshape8gradients_4/loss_8/add_1_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_4_grad/Reshape/shape*
_output_shapes
:*
Tshape0*
T0
o
#gradients_4/loss_8/Sum_4_grad/ShapeShapeloss_8/pow_2*
_output_shapes
:*
T0*
out_type0
ґ
"gradients_4/loss_8/Sum_4_grad/TileTile%gradients_4/loss_8/Sum_4_grad/Reshape#gradients_4/loss_8/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:€€€€€€€€€*
T0
|
+gradients_4/loss_8/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_4/loss_8/Sum_5_grad/ReshapeReshape8gradients_4/loss_8/mul_3_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_5_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_4/loss_8/Sum_5_grad/ShapeShapeloss_8/pow_3*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_4/loss_8/Sum_5_grad/TileTile%gradients_4/loss_8/Sum_5_grad/Reshape#gradients_4/loss_8/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_4/loss_8/pow_4_grad/ShapeShapeloss_8/neg_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_4_grad/Shape%gradients_4/loss_8/pow_4_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_4/loss_8/pow_4_grad/mulMul"gradients_4/loss_8/Sum_6_grad/Tileloss_8/pow_4/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_4/loss_8/pow_4_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_4_grad/subSubloss_8/pow_4/y#gradients_4/loss_8/pow_4_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_4_grad/PowPowloss_8/neg_item_bias!gradients_4/loss_8/pow_4_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_4/loss_8/pow_4_grad/mul_1Mul!gradients_4/loss_8/pow_4_grad/mul!gradients_4/loss_8/pow_4_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_4/loss_8/pow_4_grad/SumSum#gradients_4/loss_8/pow_4_grad/mul_13gradients_4/loss_8/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/pow_4_grad/ReshapeReshape!gradients_4/loss_8/pow_4_grad/Sum#gradients_4/loss_8/pow_4_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_4/loss_8/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_4_grad/GreaterGreaterloss_8/neg_item_bias'gradients_4/loss_8/pow_4_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_4/loss_8/pow_4_grad/LogLogloss_8/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_4/loss_8/pow_4_grad/zeros_like	ZerosLikeloss_8/neg_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_4/loss_8/pow_4_grad/SelectSelect%gradients_4/loss_8/pow_4_grad/Greater!gradients_4/loss_8/pow_4_grad/Log(gradients_4/loss_8/pow_4_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_4/loss_8/pow_4_grad/mul_2Mul"gradients_4/loss_8/Sum_6_grad/Tileloss_8/pow_4*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_4/loss_8/pow_4_grad/mul_3Mul#gradients_4/loss_8/pow_4_grad/mul_2$gradients_4/loss_8/pow_4_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_4/loss_8/pow_4_grad/Sum_1Sum#gradients_4/loss_8/pow_4_grad/mul_35gradients_4/loss_8/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_4_grad/Reshape_1Reshape#gradients_4/loss_8/pow_4_grad/Sum_1%gradients_4/loss_8/pow_4_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/pow_4_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_4_grad/Reshape(^gradients_4/loss_8/pow_4_grad/Reshape_1
В
6gradients_4/loss_8/pow_4_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_4_grad/Reshape/^gradients_4/loss_8/pow_4_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_4_grad/Reshape
ы
8gradients_4/loss_8/pow_4_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_4_grad/Reshape_1/^gradients_4/loss_8/pow_4_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_4_grad/Reshape_1
Б
3gradients_4/loss_8/clip_by_value/Minimum_grad/ShapeShapeloss_8/Sigmoid*
_output_shapes
:*
T0*
out_type0
x
5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
≥
5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_2Shape>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency*
_output_shapes
:*
T0*
out_type0
~
9gradients_4/loss_8/clip_by_value/Minimum_grad/zeros/ConstConst*
valueB
 *    *
_output_shapes
: *
dtype0
џ
3gradients_4/loss_8/clip_by_value/Minimum_grad/zerosFill5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_29gradients_4/loss_8/clip_by_value/Minimum_grad/zeros/Const*#
_output_shapes
:€€€€€€€€€*
T0
Ґ
7gradients_4/loss_8/clip_by_value/Minimum_grad/LessEqual	LessEqualloss_8/Sigmoidloss_8/clip_by_value/Minimum/y*#
_output_shapes
:€€€€€€€€€*
T0
Е
Cgradients_4/loss_8/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs3gradients_4/loss_8/clip_by_value/Minimum_grad/Shape5gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ъ
4gradients_4/loss_8/clip_by_value/Minimum_grad/SelectSelect7gradients_4/loss_8/clip_by_value/Minimum_grad/LessEqual>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency3gradients_4/loss_8/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
§
8gradients_4/loss_8/clip_by_value/Minimum_grad/LogicalNot
LogicalNot7gradients_4/loss_8/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:€€€€€€€€€
Э
6gradients_4/loss_8/clip_by_value/Minimum_grad/Select_1Select8gradients_4/loss_8/clip_by_value/Minimum_grad/LogicalNot>gradients_4/loss_8/clip_by_value_grad/tuple/control_dependency3gradients_4/loss_8/clip_by_value/Minimum_grad/zeros*#
_output_shapes
:€€€€€€€€€*
T0
у
1gradients_4/loss_8/clip_by_value/Minimum_grad/SumSum4gradients_4/loss_8/clip_by_value/Minimum_grad/SelectCgradients_4/loss_8/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
д
5gradients_4/loss_8/clip_by_value/Minimum_grad/ReshapeReshape1gradients_4/loss_8/clip_by_value/Minimum_grad/Sum3gradients_4/loss_8/clip_by_value/Minimum_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
щ
3gradients_4/loss_8/clip_by_value/Minimum_grad/Sum_1Sum6gradients_4/loss_8/clip_by_value/Minimum_grad/Select_1Egradients_4/loss_8/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ё
7gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1Reshape3gradients_4/loss_8/clip_by_value/Minimum_grad/Sum_15gradients_4/loss_8/clip_by_value/Minimum_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
Є
>gradients_4/loss_8/clip_by_value/Minimum_grad/tuple/group_depsNoOp6^gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape8^gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1
¬
Fgradients_4/loss_8/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity5gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape?^gradients_4/loss_8/clip_by_value/Minimum_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*H
_class>
<:loc:@gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape
ї
Hgradients_4/loss_8/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity7gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1?^gradients_4/loss_8/clip_by_value/Minimum_grad/tuple/group_deps*
_output_shapes
: *
T0*J
_class@
><loc:@gradients_4/loss_8/clip_by_value/Minimum_grad/Reshape_1
m
!gradients_4/loss_8/pow_grad/ShapeShapeloss_8/users*
_output_shapes
:*
T0*
out_type0
f
#gradients_4/loss_8/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
ѕ
1gradients_4/loss_8/pow_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/pow_grad/Shape#gradients_4/loss_8/pow_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
gradients_4/loss_8/pow_grad/mulMul"gradients_4/loss_8/Sum_2_grad/Tileloss_8/pow/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
!gradients_4/loss_8/pow_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
x
gradients_4/loss_8/pow_grad/subSubloss_8/pow/y!gradients_4/loss_8/pow_grad/sub/y*
_output_shapes
: *
T0
З
gradients_4/loss_8/pow_grad/PowPowloss_8/usersgradients_4/loss_8/pow_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ь
!gradients_4/loss_8/pow_grad/mul_1Mulgradients_4/loss_8/pow_grad/mulgradients_4/loss_8/pow_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
Љ
gradients_4/loss_8/pow_grad/SumSum!gradients_4/loss_8/pow_grad/mul_11gradients_4/loss_8/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_4/loss_8/pow_grad/ReshapeReshapegradients_4/loss_8/pow_grad/Sum!gradients_4/loss_8/pow_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
j
%gradients_4/loss_8/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Х
#gradients_4/loss_8/pow_grad/GreaterGreaterloss_8/users%gradients_4/loss_8/pow_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
f
gradients_4/loss_8/pow_grad/LogLogloss_8/users*'
_output_shapes
:€€€€€€€€€
*
T0
s
&gradients_4/loss_8/pow_grad/zeros_like	ZerosLikeloss_8/users*'
_output_shapes
:€€€€€€€€€
*
T0
ћ
"gradients_4/loss_8/pow_grad/SelectSelect#gradients_4/loss_8/pow_grad/Greatergradients_4/loss_8/pow_grad/Log&gradients_4/loss_8/pow_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
К
!gradients_4/loss_8/pow_grad/mul_2Mul"gradients_4/loss_8/Sum_2_grad/Tile
loss_8/pow*'
_output_shapes
:€€€€€€€€€
*
T0
°
!gradients_4/loss_8/pow_grad/mul_3Mul!gradients_4/loss_8/pow_grad/mul_2"gradients_4/loss_8/pow_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_4/loss_8/pow_grad/Sum_1Sum!gradients_4/loss_8/pow_grad/mul_33gradients_4/loss_8/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
І
%gradients_4/loss_8/pow_grad/Reshape_1Reshape!gradients_4/loss_8/pow_grad/Sum_1#gradients_4/loss_8/pow_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
В
,gradients_4/loss_8/pow_grad/tuple/group_depsNoOp$^gradients_4/loss_8/pow_grad/Reshape&^gradients_4/loss_8/pow_grad/Reshape_1
ю
4gradients_4/loss_8/pow_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/pow_grad/Reshape-^gradients_4/loss_8/pow_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_4/loss_8/pow_grad/Reshape
у
6gradients_4/loss_8/pow_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/pow_grad/Reshape_1-^gradients_4/loss_8/pow_grad/tuple/group_deps*
_output_shapes
: *
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_grad/Reshape_1
|
+gradients_4/loss_8/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
ќ
%gradients_4/loss_8/Sum_3_grad/ReshapeReshape8gradients_4/loss_8/mul_2_grad/tuple/control_dependency_1+gradients_4/loss_8/Sum_3_grad/Reshape/shape*
_output_shapes

:*
Tshape0*
T0
o
#gradients_4/loss_8/Sum_3_grad/ShapeShapeloss_8/pow_1*
_output_shapes
:*
T0*
out_type0
Ї
"gradients_4/loss_8/Sum_3_grad/TileTile%gradients_4/loss_8/Sum_3_grad/Reshape#gradients_4/loss_8/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
w
#gradients_4/loss_8/pow_2_grad/ShapeShapeloss_8/pos_item_bias*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_2_grad/Shape%gradients_4/loss_8/pow_2_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
К
!gradients_4/loss_8/pow_2_grad/mulMul"gradients_4/loss_8/Sum_4_grad/Tileloss_8/pow_2/y*#
_output_shapes
:€€€€€€€€€*
T0
h
#gradients_4/loss_8/pow_2_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_2_grad/subSubloss_8/pow_2/y#gradients_4/loss_8/pow_2_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_2_grad/PowPowloss_8/pos_item_bias!gradients_4/loss_8/pow_2_grad/sub*#
_output_shapes
:€€€€€€€€€*
T0
Ю
#gradients_4/loss_8/pow_2_grad/mul_1Mul!gradients_4/loss_8/pow_2_grad/mul!gradients_4/loss_8/pow_2_grad/Pow*#
_output_shapes
:€€€€€€€€€*
T0
¬
!gradients_4/loss_8/pow_2_grad/SumSum#gradients_4/loss_8/pow_2_grad/mul_13gradients_4/loss_8/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/pow_2_grad/ReshapeReshape!gradients_4/loss_8/pow_2_grad/Sum#gradients_4/loss_8/pow_2_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
l
'gradients_4/loss_8/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_2_grad/GreaterGreaterloss_8/pos_item_bias'gradients_4/loss_8/pow_2_grad/Greater/y*#
_output_shapes
:€€€€€€€€€*
T0
l
!gradients_4/loss_8/pow_2_grad/LogLogloss_8/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
y
(gradients_4/loss_8/pow_2_grad/zeros_like	ZerosLikeloss_8/pos_item_bias*#
_output_shapes
:€€€€€€€€€*
T0
–
$gradients_4/loss_8/pow_2_grad/SelectSelect%gradients_4/loss_8/pow_2_grad/Greater!gradients_4/loss_8/pow_2_grad/Log(gradients_4/loss_8/pow_2_grad/zeros_like*#
_output_shapes
:€€€€€€€€€*
T0
К
#gradients_4/loss_8/pow_2_grad/mul_2Mul"gradients_4/loss_8/Sum_4_grad/Tileloss_8/pow_2*#
_output_shapes
:€€€€€€€€€*
T0
£
#gradients_4/loss_8/pow_2_grad/mul_3Mul#gradients_4/loss_8/pow_2_grad/mul_2$gradients_4/loss_8/pow_2_grad/Select*#
_output_shapes
:€€€€€€€€€*
T0
∆
#gradients_4/loss_8/pow_2_grad/Sum_1Sum#gradients_4/loss_8/pow_2_grad/mul_35gradients_4/loss_8/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_2_grad/Reshape_1Reshape#gradients_4/loss_8/pow_2_grad/Sum_1%gradients_4/loss_8/pow_2_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/pow_2_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_2_grad/Reshape(^gradients_4/loss_8/pow_2_grad/Reshape_1
В
6gradients_4/loss_8/pow_2_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_2_grad/Reshape/^gradients_4/loss_8/pow_2_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_2_grad/Reshape
ы
8gradients_4/loss_8/pow_2_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_2_grad/Reshape_1/^gradients_4/loss_8/pow_2_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_2_grad/Reshape_1
s
#gradients_4/loss_8/pow_3_grad/ShapeShapeloss_8/neg_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_3_grad/Shape%gradients_4/loss_8/pow_3_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_4/loss_8/pow_3_grad/mulMul"gradients_4/loss_8/Sum_5_grad/Tileloss_8/pow_3/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_4/loss_8/pow_3_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_3_grad/subSubloss_8/pow_3/y#gradients_4/loss_8/pow_3_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_3_grad/PowPowloss_8/neg_items!gradients_4/loss_8/pow_3_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_4/loss_8/pow_3_grad/mul_1Mul!gradients_4/loss_8/pow_3_grad/mul!gradients_4/loss_8/pow_3_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_4/loss_8/pow_3_grad/SumSum#gradients_4/loss_8/pow_3_grad/mul_13gradients_4/loss_8/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_4/loss_8/pow_3_grad/ReshapeReshape!gradients_4/loss_8/pow_3_grad/Sum#gradients_4/loss_8/pow_3_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_4/loss_8/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_3_grad/GreaterGreaterloss_8/neg_items'gradients_4/loss_8/pow_3_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_4/loss_8/pow_3_grad/LogLogloss_8/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_4/loss_8/pow_3_grad/zeros_like	ZerosLikeloss_8/neg_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_4/loss_8/pow_3_grad/SelectSelect%gradients_4/loss_8/pow_3_grad/Greater!gradients_4/loss_8/pow_3_grad/Log(gradients_4/loss_8/pow_3_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_4/loss_8/pow_3_grad/mul_2Mul"gradients_4/loss_8/Sum_5_grad/Tileloss_8/pow_3*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_4/loss_8/pow_3_grad/mul_3Mul#gradients_4/loss_8/pow_3_grad/mul_2$gradients_4/loss_8/pow_3_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_4/loss_8/pow_3_grad/Sum_1Sum#gradients_4/loss_8/pow_3_grad/mul_35gradients_4/loss_8/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_3_grad/Reshape_1Reshape#gradients_4/loss_8/pow_3_grad/Sum_1%gradients_4/loss_8/pow_3_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/pow_3_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_3_grad/Reshape(^gradients_4/loss_8/pow_3_grad/Reshape_1
Ж
6gradients_4/loss_8/pow_3_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_3_grad/Reshape/^gradients_4/loss_8/pow_3_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_3_grad/Reshape
ы
8gradients_4/loss_8/pow_3_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_3_grad/Reshape_1/^gradients_4/loss_8/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_3_grad/Reshape_1
ј
+gradients_4/loss_8/Sigmoid_grad/SigmoidGradSigmoidGradloss_8/SigmoidFgradients_4/loss_8/clip_by_value/Minimum_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0
s
#gradients_4/loss_8/pow_1_grad/ShapeShapeloss_8/pos_items*
_output_shapes
:*
T0*
out_type0
h
%gradients_4/loss_8/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
’
3gradients_4/loss_8/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/pow_1_grad/Shape%gradients_4/loss_8/pow_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
О
!gradients_4/loss_8/pow_1_grad/mulMul"gradients_4/loss_8/Sum_3_grad/Tileloss_8/pow_1/y*'
_output_shapes
:€€€€€€€€€
*
T0
h
#gradients_4/loss_8/pow_1_grad/sub/yConst*
valueB
 *  А?*
_output_shapes
: *
dtype0
~
!gradients_4/loss_8/pow_1_grad/subSubloss_8/pow_1/y#gradients_4/loss_8/pow_1_grad/sub/y*
_output_shapes
: *
T0
П
!gradients_4/loss_8/pow_1_grad/PowPowloss_8/pos_items!gradients_4/loss_8/pow_1_grad/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ґ
#gradients_4/loss_8/pow_1_grad/mul_1Mul!gradients_4/loss_8/pow_1_grad/mul!gradients_4/loss_8/pow_1_grad/Pow*'
_output_shapes
:€€€€€€€€€
*
T0
¬
!gradients_4/loss_8/pow_1_grad/SumSum#gradients_4/loss_8/pow_1_grad/mul_13gradients_4/loss_8/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_4/loss_8/pow_1_grad/ReshapeReshape!gradients_4/loss_8/pow_1_grad/Sum#gradients_4/loss_8/pow_1_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
l
'gradients_4/loss_8/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0
Э
%gradients_4/loss_8/pow_1_grad/GreaterGreaterloss_8/pos_items'gradients_4/loss_8/pow_1_grad/Greater/y*'
_output_shapes
:€€€€€€€€€
*
T0
l
!gradients_4/loss_8/pow_1_grad/LogLogloss_8/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
y
(gradients_4/loss_8/pow_1_grad/zeros_like	ZerosLikeloss_8/pos_items*'
_output_shapes
:€€€€€€€€€
*
T0
‘
$gradients_4/loss_8/pow_1_grad/SelectSelect%gradients_4/loss_8/pow_1_grad/Greater!gradients_4/loss_8/pow_1_grad/Log(gradients_4/loss_8/pow_1_grad/zeros_like*'
_output_shapes
:€€€€€€€€€
*
T0
О
#gradients_4/loss_8/pow_1_grad/mul_2Mul"gradients_4/loss_8/Sum_3_grad/Tileloss_8/pow_1*'
_output_shapes
:€€€€€€€€€
*
T0
І
#gradients_4/loss_8/pow_1_grad/mul_3Mul#gradients_4/loss_8/pow_1_grad/mul_2$gradients_4/loss_8/pow_1_grad/Select*'
_output_shapes
:€€€€€€€€€
*
T0
∆
#gradients_4/loss_8/pow_1_grad/Sum_1Sum#gradients_4/loss_8/pow_1_grad/mul_35gradients_4/loss_8/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≠
'gradients_4/loss_8/pow_1_grad/Reshape_1Reshape#gradients_4/loss_8/pow_1_grad/Sum_1%gradients_4/loss_8/pow_1_grad/Shape_1*
_output_shapes
: *
Tshape0*
T0
И
.gradients_4/loss_8/pow_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/pow_1_grad/Reshape(^gradients_4/loss_8/pow_1_grad/Reshape_1
Ж
6gradients_4/loss_8/pow_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/pow_1_grad/Reshape/^gradients_4/loss_8/pow_1_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/pow_1_grad/Reshape
ы
8gradients_4/loss_8/pow_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/pow_1_grad/Reshape_1/^gradients_4/loss_8/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*:
_class0
.,loc:@gradients_4/loss_8/pow_1_grad/Reshape_1
m
!gradients_4/loss_8/add_grad/ShapeShapeloss_8/sub_1*
_output_shapes
:*
T0*
out_type0
m
#gradients_4/loss_8/add_grad/Shape_1Shape
loss_8/Sum*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_4/loss_8/add_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/add_grad/Shape#gradients_4/loss_8/add_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
∆
gradients_4/loss_8/add_grad/SumSum+gradients_4/loss_8/Sigmoid_grad/SigmoidGrad1gradients_4/loss_8/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Ѓ
#gradients_4/loss_8/add_grad/ReshapeReshapegradients_4/loss_8/add_grad/Sum!gradients_4/loss_8/add_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
!gradients_4/loss_8/add_grad/Sum_1Sum+gradients_4/loss_8/Sigmoid_grad/SigmoidGrad3gradients_4/loss_8/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/add_grad/Reshape_1Reshape!gradients_4/loss_8/add_grad/Sum_1#gradients_4/loss_8/add_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
В
,gradients_4/loss_8/add_grad/tuple/group_depsNoOp$^gradients_4/loss_8/add_grad/Reshape&^gradients_4/loss_8/add_grad/Reshape_1
ъ
4gradients_4/loss_8/add_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/add_grad/Reshape-^gradients_4/loss_8/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*6
_class,
*(loc:@gradients_4/loss_8/add_grad/Reshape
А
6gradients_4/loss_8/add_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/add_grad/Reshape_1-^gradients_4/loss_8/add_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/add_grad/Reshape_1
w
#gradients_4/loss_8/sub_1_grad/ShapeShapeloss_8/pos_item_bias*
_output_shapes
:*
T0*
out_type0
y
%gradients_4/loss_8/sub_1_grad/Shape_1Shapeloss_8/neg_item_bias*
_output_shapes
:*
T0*
out_type0
’
3gradients_4/loss_8/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgs#gradients_4/loss_8/sub_1_grad/Shape%gradients_4/loss_8/sub_1_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
”
!gradients_4/loss_8/sub_1_grad/SumSum4gradients_4/loss_8/add_grad/tuple/control_dependency3gradients_4/loss_8/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
і
%gradients_4/loss_8/sub_1_grad/ReshapeReshape!gradients_4/loss_8/sub_1_grad/Sum#gradients_4/loss_8/sub_1_grad/Shape*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
„
#gradients_4/loss_8/sub_1_grad/Sum_1Sum4gradients_4/loss_8/add_grad/tuple/control_dependency5gradients_4/loss_8/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
p
!gradients_4/loss_8/sub_1_grad/NegNeg#gradients_4/loss_8/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Є
'gradients_4/loss_8/sub_1_grad/Reshape_1Reshape!gradients_4/loss_8/sub_1_grad/Neg%gradients_4/loss_8/sub_1_grad/Shape_1*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
И
.gradients_4/loss_8/sub_1_grad/tuple/group_depsNoOp&^gradients_4/loss_8/sub_1_grad/Reshape(^gradients_4/loss_8/sub_1_grad/Reshape_1
В
6gradients_4/loss_8/sub_1_grad/tuple/control_dependencyIdentity%gradients_4/loss_8/sub_1_grad/Reshape/^gradients_4/loss_8/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*8
_class.
,*loc:@gradients_4/loss_8/sub_1_grad/Reshape
И
8gradients_4/loss_8/sub_1_grad/tuple/control_dependency_1Identity'gradients_4/loss_8/sub_1_grad/Reshape_1/^gradients_4/loss_8/sub_1_grad/tuple/group_deps*#
_output_shapes
:€€€€€€€€€*
T0*:
_class0
.,loc:@gradients_4/loss_8/sub_1_grad/Reshape_1
k
!gradients_4/loss_8/Sum_grad/ShapeShape
loss_8/mul*
_output_shapes
:*
T0*
out_type0
b
 gradients_4/loss_8/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
З
gradients_4/loss_8/Sum_grad/addAddloss_8/Sum/reduction_indices gradients_4/loss_8/Sum_grad/Size*
_output_shapes
: *
T0
П
gradients_4/loss_8/Sum_grad/modFloorModgradients_4/loss_8/Sum_grad/add gradients_4/loss_8/Sum_grad/Size*
_output_shapes
: *
T0
f
#gradients_4/loss_8/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
i
'gradients_4/loss_8/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
i
'gradients_4/loss_8/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
∆
!gradients_4/loss_8/Sum_grad/rangeRange'gradients_4/loss_8/Sum_grad/range/start gradients_4/loss_8/Sum_grad/Size'gradients_4/loss_8/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
h
&gradients_4/loss_8/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0
Ц
 gradients_4/loss_8/Sum_grad/FillFill#gradients_4/loss_8/Sum_grad/Shape_1&gradients_4/loss_8/Sum_grad/Fill/value*
_output_shapes
: *
T0
ъ
)gradients_4/loss_8/Sum_grad/DynamicStitchDynamicStitch!gradients_4/loss_8/Sum_grad/rangegradients_4/loss_8/Sum_grad/mod!gradients_4/loss_8/Sum_grad/Shape gradients_4/loss_8/Sum_grad/Fill*#
_output_shapes
:€€€€€€€€€*
T0*
N
g
%gradients_4/loss_8/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ѓ
#gradients_4/loss_8/Sum_grad/MaximumMaximum)gradients_4/loss_8/Sum_grad/DynamicStitch%gradients_4/loss_8/Sum_grad/Maximum/y*#
_output_shapes
:€€€€€€€€€*
T0
Э
$gradients_4/loss_8/Sum_grad/floordivFloorDiv!gradients_4/loss_8/Sum_grad/Shape#gradients_4/loss_8/Sum_grad/Maximum*
_output_shapes
:*
T0
¬
#gradients_4/loss_8/Sum_grad/ReshapeReshape6gradients_4/loss_8/add_grad/tuple/control_dependency_1)gradients_4/loss_8/Sum_grad/DynamicStitch*
_output_shapes
:*
Tshape0*
T0
Ј
 gradients_4/loss_8/Sum_grad/TileTile#gradients_4/loss_8/Sum_grad/Reshape$gradients_4/loss_8/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:€€€€€€€€€
*
T0
щ
gradients_4/AddNAddN6gradients_4/loss_8/pow_2_grad/tuple/control_dependency6gradients_4/loss_8/sub_1_grad/tuple/control_dependency*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_4/loss_8/pow_2_grad/Reshape
†
+gradients_4/loss_8/pos_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_4/item_bias
Е
*gradients_4/loss_8/pos_item_bias_grad/SizeSize placeholders_4/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_4/loss_8/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_4/loss_8/pos_item_bias_grad/ExpandDims
ExpandDims*gradients_4/loss_8/pos_item_bias_grad/Size4gradients_4/loss_8/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_4/loss_8/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_4/loss_8/pos_item_bias_grad/strided_sliceStridedSlice+gradients_4/loss_8/pos_item_bias_grad/Shape9gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_1;gradients_4/loss_8/pos_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_4/loss_8/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_4/loss_8/pos_item_bias_grad/concatConcatV20gradients_4/loss_8/pos_item_bias_grad/ExpandDims3gradients_4/loss_8/pos_item_bias_grad/strided_slice1gradients_4/loss_8/pos_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
і
-gradients_4/loss_8/pos_item_bias_grad/ReshapeReshapegradients_4/AddN,gradients_4/loss_8/pos_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_4/loss_8/pos_item_bias_grad/Reshape_1Reshape placeholders_4/sampled_pos_items0gradients_4/loss_8/pos_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
э
gradients_4/AddN_1AddN6gradients_4/loss_8/pow_4_grad/tuple/control_dependency8gradients_4/loss_8/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:€€€€€€€€€*
T0*
N*8
_class.
,*loc:@gradients_4/loss_8/pow_4_grad/Reshape
†
+gradients_4/loss_8/neg_item_bias_grad/ShapeConst*
valueB:з*
_output_shapes
:*
dtype0*(
_class
loc:@variables_4/item_bias
Е
*gradients_4/loss_8/neg_item_bias_grad/SizeSize placeholders_4/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
v
4gradients_4/loss_8/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
—
0gradients_4/loss_8/neg_item_bias_grad/ExpandDims
ExpandDims*gradients_4/loss_8/neg_item_bias_grad/Size4gradients_4/loss_8/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
Г
9gradients_4/loss_8/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Е
;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
є
3gradients_4/loss_8/neg_item_bias_grad/strided_sliceStridedSlice+gradients_4/loss_8/neg_item_bias_grad/Shape9gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_1;gradients_4/loss_8/neg_item_bias_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
: *
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
s
1gradients_4/loss_8/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
М
,gradients_4/loss_8/neg_item_bias_grad/concatConcatV20gradients_4/loss_8/neg_item_bias_grad/ExpandDims3gradients_4/loss_8/neg_item_bias_grad/strided_slice1gradients_4/loss_8/neg_item_bias_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ґ
-gradients_4/loss_8/neg_item_bias_grad/ReshapeReshapegradients_4/AddN_1,gradients_4/loss_8/neg_item_bias_grad/concat*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
 
/gradients_4/loss_8/neg_item_bias_grad/Reshape_1Reshape placeholders_4/sampled_neg_items0gradients_4/loss_8/neg_item_bias_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
m
!gradients_4/loss_8/mul_grad/ShapeShapeloss_8/users*
_output_shapes
:*
T0*
out_type0
m
#gradients_4/loss_8/mul_grad/Shape_1Shape
loss_8/sub*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_4/loss_8/mul_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/mul_grad/Shape#gradients_4/loss_8/mul_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
Ж
gradients_4/loss_8/mul_grad/mulMul gradients_4/loss_8/Sum_grad/Tile
loss_8/sub*'
_output_shapes
:€€€€€€€€€
*
T0
Ї
gradients_4/loss_8/mul_grad/SumSumgradients_4/loss_8/mul_grad/mul1gradients_4/loss_8/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_4/loss_8/mul_grad/ReshapeReshapegradients_4/loss_8/mul_grad/Sum!gradients_4/loss_8/mul_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
К
!gradients_4/loss_8/mul_grad/mul_1Mulloss_8/users gradients_4/loss_8/Sum_grad/Tile*'
_output_shapes
:€€€€€€€€€
*
T0
ј
!gradients_4/loss_8/mul_grad/Sum_1Sum!gradients_4/loss_8/mul_grad/mul_13gradients_4/loss_8/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
Є
%gradients_4/loss_8/mul_grad/Reshape_1Reshape!gradients_4/loss_8/mul_grad/Sum_1#gradients_4/loss_8/mul_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_4/loss_8/mul_grad/tuple/group_depsNoOp$^gradients_4/loss_8/mul_grad/Reshape&^gradients_4/loss_8/mul_grad/Reshape_1
ю
4gradients_4/loss_8/mul_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/mul_grad/Reshape-^gradients_4/loss_8/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_4/loss_8/mul_grad/Reshape
Д
6gradients_4/loss_8/mul_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/mul_grad/Reshape_1-^gradients_4/loss_8/mul_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/mul_grad/Reshape_1
Y
gradients_4/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_4/concatConcatV2-gradients_4/loss_8/pos_item_bias_grad/Reshape-gradients_4/loss_8/neg_item_bias_grad/Reshapegradients_4/concat/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_4/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
а
gradients_4/concat_1ConcatV2/gradients_4/loss_8/pos_item_bias_grad/Reshape_1/gradients_4/loss_8/neg_item_bias_grad/Reshape_1gradients_4/concat_1/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
щ
gradients_4/AddN_2AddN4gradients_4/loss_8/pow_grad/tuple/control_dependency4gradients_4/loss_8/mul_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*6
_class,
*(loc:@gradients_4/loss_8/pow_grad/Reshape
°
#gradients_4/loss_8/users_grad/ShapeConst*
valueB"d  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_4/user_factors
y
"gradients_4/loss_8/users_grad/SizeSizeplaceholders_4/sampled_users*
_output_shapes
: *
T0*
out_type0
n
,gradients_4/loss_8/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
є
(gradients_4/loss_8/users_grad/ExpandDims
ExpandDims"gradients_4/loss_8/users_grad/Size,gradients_4/loss_8/users_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0
{
1gradients_4/loss_8/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients_4/loss_8/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients_4/loss_8/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
У
+gradients_4/loss_8/users_grad/strided_sliceStridedSlice#gradients_4/loss_8/users_grad/Shape1gradients_4/loss_8/users_grad/strided_slice/stack3gradients_4/loss_8/users_grad/strided_slice/stack_13gradients_4/loss_8/users_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
k
)gradients_4/loss_8/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
$gradients_4/loss_8/users_grad/concatConcatV2(gradients_4/loss_8/users_grad/ExpandDims+gradients_4/loss_8/users_grad/strided_slice)gradients_4/loss_8/users_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
≥
%gradients_4/loss_8/users_grad/ReshapeReshapegradients_4/AddN_2$gradients_4/loss_8/users_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
ґ
'gradients_4/loss_8/users_grad/Reshape_1Reshapeplaceholders_4/sampled_users(gradients_4/loss_8/users_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
q
!gradients_4/loss_8/sub_grad/ShapeShapeloss_8/pos_items*
_output_shapes
:*
T0*
out_type0
s
#gradients_4/loss_8/sub_grad/Shape_1Shapeloss_8/neg_items*
_output_shapes
:*
T0*
out_type0
ѕ
1gradients_4/loss_8/sub_grad/BroadcastGradientArgsBroadcastGradientArgs!gradients_4/loss_8/sub_grad/Shape#gradients_4/loss_8/sub_grad/Shape_1*2
_output_shapes 
:€€€€€€€€€:€€€€€€€€€*
T0
—
gradients_4/loss_8/sub_grad/SumSum6gradients_4/loss_8/mul_grad/tuple/control_dependency_11gradients_4/loss_8/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
≤
#gradients_4/loss_8/sub_grad/ReshapeReshapegradients_4/loss_8/sub_grad/Sum!gradients_4/loss_8/sub_grad/Shape*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
’
!gradients_4/loss_8/sub_grad/Sum_1Sum6gradients_4/loss_8/mul_grad/tuple/control_dependency_13gradients_4/loss_8/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *
T0*

Tidx0
l
gradients_4/loss_8/sub_grad/NegNeg!gradients_4/loss_8/sub_grad/Sum_1*
_output_shapes
:*
T0
ґ
%gradients_4/loss_8/sub_grad/Reshape_1Reshapegradients_4/loss_8/sub_grad/Neg#gradients_4/loss_8/sub_grad/Shape_1*'
_output_shapes
:€€€€€€€€€
*
Tshape0*
T0
В
,gradients_4/loss_8/sub_grad/tuple/group_depsNoOp$^gradients_4/loss_8/sub_grad/Reshape&^gradients_4/loss_8/sub_grad/Reshape_1
ю
4gradients_4/loss_8/sub_grad/tuple/control_dependencyIdentity#gradients_4/loss_8/sub_grad/Reshape-^gradients_4/loss_8/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*6
_class,
*(loc:@gradients_4/loss_8/sub_grad/Reshape
Д
6gradients_4/loss_8/sub_grad/tuple/control_dependency_1Identity%gradients_4/loss_8/sub_grad/Reshape_1-^gradients_4/loss_8/sub_grad/tuple/group_deps*'
_output_shapes
:€€€€€€€€€
*
T0*8
_class.
,*loc:@gradients_4/loss_8/sub_grad/Reshape_1
э
gradients_4/AddN_3AddN6gradients_4/loss_8/pow_1_grad/tuple/control_dependency4gradients_4/loss_8/sub_grad/tuple/control_dependency*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_4/loss_8/pow_1_grad/Reshape
•
'gradients_4/loss_8/pos_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_4/item_factors
Б
&gradients_4/loss_8/pos_items_grad/SizeSize placeholders_4/sampled_pos_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_4/loss_8/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_4/loss_8/pos_items_grad/ExpandDims
ExpandDims&gradients_4/loss_8/pos_items_grad/Size0gradients_4/loss_8/pos_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_4/loss_8/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_4/loss_8/pos_items_grad/strided_sliceStridedSlice'gradients_4/loss_8/pos_items_grad/Shape5gradients_4/loss_8/pos_items_grad/strided_slice/stack7gradients_4/loss_8/pos_items_grad/strided_slice/stack_17gradients_4/loss_8/pos_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_4/loss_8/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_4/loss_8/pos_items_grad/concatConcatV2,gradients_4/loss_8/pos_items_grad/ExpandDims/gradients_4/loss_8/pos_items_grad/strided_slice-gradients_4/loss_8/pos_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_4/loss_8/pos_items_grad/ReshapeReshapegradients_4/AddN_3(gradients_4/loss_8/pos_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_4/loss_8/pos_items_grad/Reshape_1Reshape placeholders_4/sampled_pos_items,gradients_4/loss_8/pos_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
€
gradients_4/AddN_4AddN6gradients_4/loss_8/pow_3_grad/tuple/control_dependency6gradients_4/loss_8/sub_grad/tuple/control_dependency_1*'
_output_shapes
:€€€€€€€€€
*
T0*
N*8
_class.
,*loc:@gradients_4/loss_8/pow_3_grad/Reshape
•
'gradients_4/loss_8/neg_items_grad/ShapeConst*
valueB"g  
   *
_output_shapes
:*
dtype0*+
_class!
loc:@variables_4/item_factors
Б
&gradients_4/loss_8/neg_items_grad/SizeSize placeholders_4/sampled_neg_items*
_output_shapes
: *
T0*
out_type0
r
0gradients_4/loss_8/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
≈
,gradients_4/loss_8/neg_items_grad/ExpandDims
ExpandDims&gradients_4/loss_8/neg_items_grad/Size0gradients_4/loss_8/neg_items_grad/ExpandDims/dim*

Tdim0*
_output_shapes
:*
T0

5gradients_4/loss_8/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
Б
7gradients_4/loss_8/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
І
/gradients_4/loss_8/neg_items_grad/strided_sliceStridedSlice'gradients_4/loss_8/neg_items_grad/Shape5gradients_4/loss_8/neg_items_grad/strided_slice/stack7gradients_4/loss_8/neg_items_grad/strided_slice/stack_17gradients_4/loss_8/neg_items_grad/strided_slice/stack_2*

begin_mask *
end_mask*
_output_shapes
:*
T0*
Index0*
shrink_axis_mask *
new_axis_mask *
ellipsis_mask 
o
-gradients_4/loss_8/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
(gradients_4/loss_8/neg_items_grad/concatConcatV2,gradients_4/loss_8/neg_items_grad/ExpandDims/gradients_4/loss_8/neg_items_grad/strided_slice-gradients_4/loss_8/neg_items_grad/concat/axis*
_output_shapes
:*
T0*
N*

Tidx0
ї
)gradients_4/loss_8/neg_items_grad/ReshapeReshapegradients_4/AddN_4(gradients_4/loss_8/neg_items_grad/concat*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
Tshape0*
T0
¬
+gradients_4/loss_8/neg_items_grad/Reshape_1Reshape placeholders_4/sampled_neg_items,gradients_4/loss_8/neg_items_grad/ExpandDims*#
_output_shapes
:€€€€€€€€€*
Tshape0*
T0
[
gradients_4/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
б
gradients_4/concat_2ConcatV2)gradients_4/loss_8/pos_items_grad/Reshape)gradients_4/loss_8/neg_items_grad/Reshapegradients_4/concat_2/axis*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*
N*

Tidx0
[
gradients_4/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ў
gradients_4/concat_3ConcatV2+gradients_4/loss_8/pos_items_grad/Reshape_1+gradients_4/loss_8/neg_items_grad/Reshape_1gradients_4/concat_3/axis*#
_output_shapes
:€€€€€€€€€*
T0*
N*

Tidx0
d
GradientDescent_4/learning_rateConst*
valueB
 *Ќћћ=*
_output_shapes
: *
dtype0
м
5GradientDescent_4/update_variables_4/user_factors/mulMul%gradients_4/loss_8/users_grad/ReshapeGradientDescent_4/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_4/user_factors
Њ
<GradientDescent_4/update_variables_4/user_factors/ScatterSub
ScatterSubvariables_4/user_factors'gradients_4/loss_8/users_grad/Reshape_15GradientDescent_4/update_variables_4/user_factors/mul*
use_locking( *
_output_shapes
:	д
*
Tindices0*
T0*+
_class!
loc:@variables_4/user_factors
џ
5GradientDescent_4/update_variables_4/item_factors/mulMulgradients_4/concat_2GradientDescent_4/learning_rate*0
_output_shapes
:€€€€€€€€€€€€€€€€€€*
T0*+
_class!
loc:@variables_4/item_factors
Ђ
<GradientDescent_4/update_variables_4/item_factors/ScatterSub
ScatterSubvariables_4/item_factorsgradients_4/concat_35GradientDescent_4/update_variables_4/item_factors/mul*
use_locking( *
_output_shapes
:	з
*
Tindices0*
T0*+
_class!
loc:@variables_4/item_factors
∆
2GradientDescent_4/update_variables_4/item_bias/mulMulgradients_4/concatGradientDescent_4/learning_rate*#
_output_shapes
:€€€€€€€€€*
T0*(
_class
loc:@variables_4/item_bias
Ы
9GradientDescent_4/update_variables_4/item_bias/ScatterSub
ScatterSubvariables_4/item_biasgradients_4/concat_12GradientDescent_4/update_variables_4/item_bias/mul*
use_locking( *
_output_shapes	
:з*
Tindices0*
T0*(
_class
loc:@variables_4/item_bias
”
GradientDescent_4NoOp=^GradientDescent_4/update_variables_4/user_factors/ScatterSub=^GradientDescent_4/update_variables_4/item_factors/ScatterSub:^GradientDescent_4/update_variables_4/item_bias/ScatterSub
R
loss_9/tagsConst*
valueB Bloss_9*
_output_shapes
: *
dtype0
S
loss_9ScalarSummaryloss_9/tagsloss_8/sub_2*
_output_shapes
: *
T0
m
Merge_4/MergeSummaryMergeSummaryloss_1loss_3loss_5loss_7loss_9*
_output_shapes
: *
N
ч
init_4NoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign ^variables_1/user_factors/Assign ^variables_1/item_factors/Assign^variables_1/item_bias/Assign ^variables_2/user_factors/Assign ^variables_2/item_factors/Assign^variables_2/item_bias/Assign ^variables_3/user_factors/Assign ^variables_3/item_factors/Assign^variables_3/item_bias/Assign ^variables_4/user_factors/Assign ^variables_4/item_factors/Assign^variables_4/item_bias/Assign""ь

trainable_variablesд
б

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
variables_1/item_bias:0variables_1/item_bias/Assignvariables_1/item_bias/read:0
^
variables_2/user_factors:0variables_2/user_factors/Assignvariables_2/user_factors/read:0
^
variables_2/item_factors:0variables_2/item_factors/Assignvariables_2/item_factors/read:0
U
variables_2/item_bias:0variables_2/item_bias/Assignvariables_2/item_bias/read:0
^
variables_3/user_factors:0variables_3/user_factors/Assignvariables_3/user_factors/read:0
^
variables_3/item_factors:0variables_3/item_factors/Assignvariables_3/item_factors/read:0
U
variables_3/item_bias:0variables_3/item_bias/Assignvariables_3/item_bias/read:0
^
variables_4/user_factors:0variables_4/user_factors/Assignvariables_4/user_factors/read:0
^
variables_4/item_factors:0variables_4/item_factors/Assignvariables_4/item_factors/read:0
U
variables_4/item_bias:0variables_4/item_bias/Assignvariables_4/item_bias/read:0"т

	variablesд
б

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
variables_1/item_bias:0variables_1/item_bias/Assignvariables_1/item_bias/read:0
^
variables_2/user_factors:0variables_2/user_factors/Assignvariables_2/user_factors/read:0
^
variables_2/item_factors:0variables_2/item_factors/Assignvariables_2/item_factors/read:0
U
variables_2/item_bias:0variables_2/item_bias/Assignvariables_2/item_bias/read:0
^
variables_3/user_factors:0variables_3/user_factors/Assignvariables_3/user_factors/read:0
^
variables_3/item_factors:0variables_3/item_factors/Assignvariables_3/item_factors/read:0
U
variables_3/item_bias:0variables_3/item_bias/Assignvariables_3/item_bias/read:0
^
variables_4/user_factors:0variables_4/user_factors/Assignvariables_4/user_factors/read:0
^
variables_4/item_factors:0variables_4/item_factors/Assignvariables_4/item_factors/read:0
U
variables_4/item_bias:0variables_4/item_bias/Assignvariables_4/item_bias/read:0"A
	summaries4
2
loss_1:0
loss_3:0
loss_5:0
loss_7:0
loss_9:0"k
train_op_
]
GradientDescent
GradientDescent_1
GradientDescent_2
GradientDescent_3
GradientDescent_4т}ЮЂ