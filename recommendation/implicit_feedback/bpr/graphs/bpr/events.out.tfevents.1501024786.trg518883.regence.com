       ЃK"	  є]жAbrain.Event:2ЙYзh'     /$	Юxє]жA"лЮ
h
placeholders/sampled_usersPlaceholder*#
_output_shapes
:џџџџџџџџџ*
dtype0*
shape: 
l
placeholders/sampled_pos_itemsPlaceholder*#
_output_shapes
:џџџџџџџџџ*
dtype0*
shape: 
l
placeholders/sampled_neg_itemsPlaceholder*#
_output_shapes
:џџџџџџџџџ*
dtype0*
shape: 
q
 variables/truncated_normal/shapeConst*
_output_shapes
:*
valueB"d  
   *
dtype0
d
variables/truncated_normal/meanConst*
_output_shapes
: *
valueB
 *    *
dtype0
f
!variables/truncated_normal/stddevConst*
_output_shapes
: *
valueB
 *шЁ>*
dtype0
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
_output_shapes
:	ф
*
seedБџх)*
T0*
dtype0*
seed2в	

variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	ф


variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	ф

s
"variables/truncated_normal_1/shapeConst*
_output_shapes
:*
valueB"g  
   *
dtype0
f
!variables/truncated_normal_1/meanConst*
_output_shapes
: *
valueB
 *    *
dtype0
h
#variables/truncated_normal_1/stddevConst*
_output_shapes
: *
valueB
 *шЁ>*
dtype0
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
_output_shapes
:	ч
*
seedБџх)*
T0*
dtype0*
seed2в	
Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	ч


variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	ч


variables/user_factors
VariableV2*
_output_shapes
:	ф
*
dtype0*
shared_name *
	container *
shape:	ф

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
T0*)
_class
loc:@variables/user_factors*
use_locking(*
_output_shapes
:	ф
*
validate_shape(

variables/user_factors/readIdentityvariables/user_factors*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	ф


variables/item_factors
VariableV2*
_output_shapes
:	ч
*
dtype0*
shared_name *
	container *
shape:	ч

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
T0*)
_class
loc:@variables/item_factors*
use_locking(*
_output_shapes
:	ч
*
validate_shape(

variables/item_factors/readIdentityvariables/item_factors*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	ч

^
variables/zerosConst*
_output_shapes	
:ч*
valueBч*    *
dtype0

variables/item_bias
VariableV2*
_output_shapes	
:ч*
dtype0*
shared_name *
	container *
shape:ч
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
T0*&
_class
loc:@variables/item_bias*
use_locking(*
_output_shapes	
:ч*
validate_shape(

variables/item_bias/readIdentityvariables/item_bias*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:ч
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ
*
Tparams0
Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ
*
Tparams0
Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ
*
Tparams0
В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*#
_output_shapes
:џџџџџџџџџ*
Tparams0
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*#
_output_shapes
:џџџџџџџџџ*
Tparams0
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
loss/Sum/reduction_indicesConst*
_output_shapes
: *
value	B :*
dtype0

loss/SumSumloss/mulloss/Sum/reduction_indices*
T0*#
_output_shapes
:џџџџџџџџџ*

Tidx0*
	keep_dims( 
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
O
loss/SigmoidSigmoidloss/add*
T0*#
_output_shapes
:џџџџџџџџџ
a
loss/clip_by_value/Minimum/yConst*
_output_shapes
: *
valueB
 *Єp}?*
dtype0

loss/clip_by_value/MinimumMinimumloss/Sigmoidloss/clip_by_value/Minimum/y*
T0*#
_output_shapes
:џџџџџџџџџ
Y
loss/clip_by_value/yConst*
_output_shapes
: *
valueB
 *ЌХ'7*
dtype0
}
loss/clip_by_valueMaximumloss/clip_by_value/Minimumloss/clip_by_value/y*
T0*#
_output_shapes
:џџџџџџџџџ
Q
loss/LogLogloss/clip_by_value*
T0*#
_output_shapes
:џџџџџџџџџ
T

loss/ConstConst*
_output_shapes
:*
valueB: *
dtype0
e

loss/Sum_1Sumloss/Log
loss/Const*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
O

loss/pow/yConst*
_output_shapes
: *
valueB
 *   @*
dtype0
Y
loss/powPow
loss/users
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_1Const*
_output_shapes
:*
valueB"       *
dtype0
g

loss/Sum_2Sumloss/powloss/Const_1*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
Q
loss/mul_1/xConst*
_output_shapes
: *
valueB
 *
з#<*
dtype0
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
_output_shapes
: *
valueB
 *   @*
dtype0
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_2Const*
_output_shapes
:*
valueB"       *
dtype0
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
Q
loss/mul_2/xConst*
_output_shapes
: *
valueB
 *
з#<*
dtype0
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
_output_shapes
: *
valueB
 *   @*
dtype0
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_3Const*
_output_shapes
:*
valueB: *
dtype0
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
J

loss/add_1Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
_output_shapes
: *
valueB
 *   @*
dtype0
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_4Const*
_output_shapes
:*
valueB"       *
dtype0
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
Q
loss/mul_3/xConst*
_output_shapes
: *
valueB
 *
з#<*
dtype0
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
_output_shapes
: *
valueB
 *   @*
dtype0
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_5Const*
_output_shapes
:*
valueB: *
dtype0
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
J

loss/add_2Add
loss/mul_3
loss/Sum_6*
T0*
_output_shapes
: 
J

loss/add_3Add
loss/mul_1
loss/add_1*
T0*
_output_shapes
: 
J

loss/add_4Add
loss/add_3
loss/add_2*
T0*
_output_shapes
: 
J

loss/sub_2Sub
loss/add_4
loss/Sum_1*
T0*
_output_shapes
: 
R
gradients/ShapeConst*
_output_shapes
: *
valueB *
dtype0
T
gradients/ConstConst*
_output_shapes
: *
valueB
 *  ?*
dtype0
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/sub_2_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
gradients/loss/add_4_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/add_4_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
_output_shapes
:*
valueB:*
dtype0
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
_output_shapes
:*
Tshape0
g
gradients/loss/Sum_1_grad/ShapeShapeloss/Log*
T0*
_output_shapes
:*
out_type0
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*

Tmultiples0
b
gradients/loss/add_3_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/add_3_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_3_grad/SumSum2gradients/loss/add_4_grad/tuple/control_dependency/gradients/loss/add_3_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Э
gradients/loss/add_3_grad/Sum_1Sum2gradients/loss/add_4_grad/tuple/control_dependency1gradients/loss/add_3_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
b
gradients/loss/add_2_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/add_2_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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

"gradients/loss/Log_grad/Reciprocal
Reciprocalloss/clip_by_value^gradients/loss/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/Log_grad/mulMulgradients/loss/Sum_1_grad/Tile"gradients/loss/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/mul_1_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/mul_1_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
_output_shapes
: *
Tshape0

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
gradients/loss/add_1_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/add_1_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_1_grad/SumSum4gradients/loss/add_3_grad/tuple/control_dependency_1/gradients/loss/add_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Я
gradients/loss/add_1_grad/Sum_1Sum4gradients/loss/add_3_grad/tuple/control_dependency_11gradients/loss/add_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/mul_3_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/mul_3_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
_output_shapes
: *
Tshape0

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
_output_shapes
:*
valueB:*
dtype0
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
_output_shapes
:*
Tshape0
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
T0*
_output_shapes
:*
out_type0
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*

Tmultiples0

'gradients/loss/clip_by_value_grad/ShapeShapeloss/clip_by_value/Minimum*
T0*
_output_shapes
:*
out_type0
l
)gradients/loss/clip_by_value_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0

)gradients/loss/clip_by_value_grad/Shape_2Shapegradients/loss/Log_grad/mul*
T0*
_output_shapes
:*
out_type0
r
-gradients/loss/clip_by_value_grad/zeros/ConstConst*
_output_shapes
: *
valueB
 *    *
dtype0
З
'gradients/loss/clip_by_value_grad/zerosFill)gradients/loss/clip_by_value_grad/Shape_2-gradients/loss/clip_by_value_grad/zeros/Const*
T0*#
_output_shapes
:џџџџџџџџџ

.gradients/loss/clip_by_value_grad/GreaterEqualGreaterEqualloss/clip_by_value/Minimumloss/clip_by_value/y*
T0*#
_output_shapes
:џџџџџџџџџ
с
7gradients/loss/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs'gradients/loss/clip_by_value_grad/Shape)gradients/loss/clip_by_value_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
ж
(gradients/loss/clip_by_value_grad/SelectSelect.gradients/loss/clip_by_value_grad/GreaterEqualgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ

,gradients/loss/clip_by_value_grad/LogicalNot
LogicalNot.gradients/loss/clip_by_value_grad/GreaterEqual*#
_output_shapes
:џџџџџџџџџ
ж
*gradients/loss/clip_by_value_grad/Select_1Select,gradients/loss/clip_by_value_grad/LogicalNotgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ
Я
%gradients/loss/clip_by_value_grad/SumSum(gradients/loss/clip_by_value_grad/Select7gradients/loss/clip_by_value_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Р
)gradients/loss/clip_by_value_grad/ReshapeReshape%gradients/loss/clip_by_value_grad/Sum'gradients/loss/clip_by_value_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
е
'gradients/loss/clip_by_value_grad/Sum_1Sum*gradients/loss/clip_by_value_grad/Select_19gradients/loss/clip_by_value_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Й
+gradients/loss/clip_by_value_grad/Reshape_1Reshape'gradients/loss/clip_by_value_grad/Sum_1)gradients/loss/clip_by_value_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0

2gradients/loss/clip_by_value_grad/tuple/group_depsNoOp*^gradients/loss/clip_by_value_grad/Reshape,^gradients/loss/clip_by_value_grad/Reshape_1

:gradients/loss/clip_by_value_grad/tuple/control_dependencyIdentity)gradients/loss/clip_by_value_grad/Reshape3^gradients/loss/clip_by_value_grad/tuple/group_deps*<
_class2
0.loc:@gradients/loss/clip_by_value_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

<gradients/loss/clip_by_value_grad/tuple/control_dependency_1Identity+gradients/loss/clip_by_value_grad/Reshape_13^gradients/loss/clip_by_value_grad/tuple/group_deps*>
_class4
20loc:@gradients/loss/clip_by_value_grad/Reshape_1*
T0*
_output_shapes
: 
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
valueB"      *
dtype0
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
_output_shapes

:*
Tshape0
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
T0*
_output_shapes
:*
out_type0
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
b
gradients/loss/mul_2_grad/ShapeConst*
_output_shapes
: *
valueB *
dtype0
d
!gradients/loss/mul_2_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_1_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
_output_shapes
: *
Tshape0

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_1_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
_output_shapes
:*
valueB:*
dtype0
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_1_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
_output_shapes
:*
Tshape0
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
T0*
_output_shapes
:*
out_type0
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*

Tmultiples0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
valueB"      *
dtype0
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
_output_shapes

:*
Tshape0
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
T0*
_output_shapes
:*
out_type0
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_4_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
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
gradients/loss/pow_4_grad/sub/yConst*
_output_shapes
: *
valueB
 *  ?*
dtype0
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
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
h
#gradients/loss/pow_4_grad/Greater/yConst*
_output_shapes
: *
valueB
 *    *
dtype0
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
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
{
/gradients/loss/clip_by_value/Minimum_grad/ShapeShapeloss/Sigmoid*
T0*
_output_shapes
:*
out_type0
t
1gradients/loss/clip_by_value/Minimum_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
Ћ
1gradients/loss/clip_by_value/Minimum_grad/Shape_2Shape:gradients/loss/clip_by_value_grad/tuple/control_dependency*
T0*
_output_shapes
:*
out_type0
z
5gradients/loss/clip_by_value/Minimum_grad/zeros/ConstConst*
_output_shapes
: *
valueB
 *    *
dtype0
Я
/gradients/loss/clip_by_value/Minimum_grad/zerosFill1gradients/loss/clip_by_value/Minimum_grad/Shape_25gradients/loss/clip_by_value/Minimum_grad/zeros/Const*
T0*#
_output_shapes
:џџџџџџџџџ

3gradients/loss/clip_by_value/Minimum_grad/LessEqual	LessEqualloss/Sigmoidloss/clip_by_value/Minimum/y*
T0*#
_output_shapes
:џџџџџџџџџ
љ
?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs/gradients/loss/clip_by_value/Minimum_grad/Shape1gradients/loss/clip_by_value/Minimum_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

0gradients/loss/clip_by_value/Minimum_grad/SelectSelect3gradients/loss/clip_by_value/Minimum_grad/LessEqual:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ

4gradients/loss/clip_by_value/Minimum_grad/LogicalNot
LogicalNot3gradients/loss/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:џџџџџџџџџ

2gradients/loss/clip_by_value/Minimum_grad/Select_1Select4gradients/loss/clip_by_value/Minimum_grad/LogicalNot:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ
ч
-gradients/loss/clip_by_value/Minimum_grad/SumSum0gradients/loss/clip_by_value/Minimum_grad/Select?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
и
1gradients/loss/clip_by_value/Minimum_grad/ReshapeReshape-gradients/loss/clip_by_value/Minimum_grad/Sum/gradients/loss/clip_by_value/Minimum_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
э
/gradients/loss/clip_by_value/Minimum_grad/Sum_1Sum2gradients/loss/clip_by_value/Minimum_grad/Select_1Agradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
б
3gradients/loss/clip_by_value/Minimum_grad/Reshape_1Reshape/gradients/loss/clip_by_value/Minimum_grad/Sum_11gradients/loss/clip_by_value/Minimum_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
Ќ
:gradients/loss/clip_by_value/Minimum_grad/tuple/group_depsNoOp2^gradients/loss/clip_by_value/Minimum_grad/Reshape4^gradients/loss/clip_by_value/Minimum_grad/Reshape_1
В
Bgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity1gradients/loss/clip_by_value/Minimum_grad/Reshape;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*D
_class:
86loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
Ћ
Dgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity3gradients/loss/clip_by_value/Minimum_grad/Reshape_1;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*F
_class<
:8loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape_1*
T0*
_output_shapes
: 
g
gradients/loss/pow_grad/ShapeShape
loss/users*
T0*
_output_shapes
:*
out_type0
b
gradients/loss/pow_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
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
gradients/loss/pow_grad/sub/yConst*
_output_shapes
: *
valueB
 *  ?*
dtype0
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
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
f
!gradients/loss/pow_grad/Greater/yConst*
_output_shapes
: *
valueB
 *    *
dtype0
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
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
_output_shapes
:*
valueB"      *
dtype0
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
_output_shapes

:*
Tshape0
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
T0*
_output_shapes
:*
out_type0
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_2_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
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
gradients/loss/pow_2_grad/sub/yConst*
_output_shapes
: *
valueB
 *  ?*
dtype0
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
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
h
#gradients/loss/pow_2_grad/Greater/yConst*
_output_shapes
: *
valueB
 *    *
dtype0
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
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_3_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
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
gradients/loss/pow_3_grad/sub/yConst*
_output_shapes
: *
valueB
 *  ?*
dtype0
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
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
h
#gradients/loss/pow_3_grad/Greater/yConst*
_output_shapes
: *
valueB
 *    *
dtype0
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
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
Ж
'gradients/loss/Sigmoid_grad/SigmoidGradSigmoidGradloss/SigmoidBgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_1_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
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
gradients/loss/pow_1_grad/sub/yConst*
_output_shapes
: *
valueB
 *  ?*
dtype0
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
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
h
#gradients/loss/pow_1_grad/Greater/yConst*
_output_shapes
: *
valueB
 *    *
dtype0
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
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
T0*
_output_shapes
:*
out_type0
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
T0*
_output_shapes
:*
out_type0
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
К
gradients/loss/add_grad/SumSum'gradients/loss/Sigmoid_grad/SigmoidGrad-gradients/loss/add_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
О
gradients/loss/add_grad/Sum_1Sum'gradients/loss/Sigmoid_grad/SigmoidGrad/gradients/loss/add_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
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
T0*
_output_shapes
:*
out_type0
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
T0*
_output_shapes
:*
out_type0
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
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
T0*
_output_shapes
:*
out_type0
^
gradients/loss/Sum_grad/SizeConst*
_output_shapes
: *
value	B :*
dtype0
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
gradients/loss/Sum_grad/Shape_1Const*
_output_shapes
: *
valueB *
dtype0
e
#gradients/loss/Sum_grad/range/startConst*
_output_shapes
: *
value	B : *
dtype0
e
#gradients/loss/Sum_grad/range/deltaConst*
_output_shapes
: *
value	B :*
dtype0
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
_output_shapes
: *
value	B :*
dtype0

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
T0*#
_output_shapes
:џџџџџџџџџ*
N
c
!gradients/loss/Sum_grad/Maximum/yConst*
_output_shapes
: *
value	B :*
dtype0
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
T0*
_output_shapes
:*
Tshape0
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ*
N

'gradients/loss/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
valueB:ч*
dtype0*&
_class
loc:@variables/item_bias

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
_output_shapes
: *
out_type0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
value	B : *
dtype0
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
valueB:*
dtype0

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
valueB: *
dtype0

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
valueB:*
dtype0
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
: 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
_output_shapes
: *
value	B : *
dtype0
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ*
N

'gradients/loss/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
valueB:ч*
dtype0*&
_class
loc:@variables/item_bias

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
_output_shapes
: *
out_type0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
value	B : *
dtype0
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
valueB:*
dtype0

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
valueB: *
dtype0

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
valueB:*
dtype0
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
: 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
_output_shapes
: *
value	B : *
dtype0
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
g
gradients/loss/mul_grad/ShapeShape
loss/users*
T0*
_output_shapes
:*
out_type0
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
T0*
_output_shapes
:*
out_type0
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
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0

gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
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
gradients/concat/axisConst*
_output_shapes
: *
value	B : *
dtype0
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
Y
gradients/concat_1/axisConst*
_output_shapes
: *
value	B : *
dtype0
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ
*
N

gradients/loss/users_grad/ShapeConst*
_output_shapes
:*
valueB"d  
   *
dtype0*)
_class
loc:@variables/user_factors
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
T0*
_output_shapes
: *
out_type0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
_output_shapes
: *
value	B : *
dtype0
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
w
-gradients/loss/users_grad/strided_slice/stackConst*
_output_shapes
:*
valueB:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
_output_shapes
:*
valueB: *
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
_output_shapes
:*
valueB:*
dtype0
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
:
g
%gradients/loss/users_grad/concat/axisConst*
_output_shapes
: *
value	B : *
dtype0
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
Tshape0
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
T0*
_output_shapes
:*
out_type0
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
T0*
_output_shapes
:*
out_type0
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
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
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ
*
N

#gradients/loss/pos_items_grad/ShapeConst*
_output_shapes
:*
valueB"g  
   *
dtype0*)
_class
loc:@variables/item_factors
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
_output_shapes
: *
out_type0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
_output_shapes
: *
value	B : *
dtype0
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
_output_shapes
:*
valueB:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
valueB: *
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
valueB:*
dtype0

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
:
k
)gradients/loss/pos_items_grad/concat/axisConst*
_output_shapes
: *
value	B : *
dtype0
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
Tshape0
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ
*
N

#gradients/loss/neg_items_grad/ShapeConst*
_output_shapes
:*
valueB"g  
   *
dtype0*)
_class
loc:@variables/item_factors
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
_output_shapes
: *
out_type0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
_output_shapes
: *
value	B : *
dtype0
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
_output_shapes
:*
valueB:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
valueB: *
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
valueB:*
dtype0

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
:
k
)gradients/loss/neg_items_grad/concat/axisConst*
_output_shapes
: *
value	B : *
dtype0
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
Tshape0
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Y
gradients/concat_2/axisConst*
_output_shapes
: *
value	B : *
dtype0
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
N*

Tidx0
Y
gradients/concat_3/axisConst*
_output_shapes
: *
value	B : *
dtype0
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
b
GradientDescent/learning_rateConst*
_output_shapes
: *
valueB
 *ЭЬЬ=*
dtype0
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*)
_class
loc:@variables/user_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
T0*
Tindices0*)
_class
loc:@variables/user_factors*
use_locking( *
_output_shapes
:	ф

б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*)
_class
loc:@variables/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
T0*
Tindices0*)
_class
loc:@variables/item_factors*
use_locking( *
_output_shapes
:	ч

М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*&
_class
loc:@variables/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
T0*
Tindices0*&
_class
loc:@variables/item_bias*
use_locking( *
_output_shapes	
:ч
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
_output_shapes
: *
valueB Bloss_1*
dtype0
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign"]OOF7     	иЃш	XЉє]жAJЙю
пН
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
2	
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
2	
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
Ttype*1.1.02v1.1.0-rc0-61-g1ec6ed5лЮ
h
placeholders/sampled_usersPlaceholder*
dtype0*#
_output_shapes
:џџџџџџџџџ*
shape: 
l
placeholders/sampled_pos_itemsPlaceholder*
dtype0*#
_output_shapes
:џџџџџџџџџ*
shape: 
l
placeholders/sampled_neg_itemsPlaceholder*
dtype0*#
_output_shapes
:џџџџџџџџџ*
shape: 
q
 variables/truncated_normal/shapeConst*
dtype0*
valueB"d  
   *
_output_shapes
:
d
variables/truncated_normal/meanConst*
dtype0*
valueB
 *    *
_output_shapes
: 
f
!variables/truncated_normal/stddevConst*
dtype0*
valueB
 *шЁ>*
_output_shapes
: 
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
dtype0*
seedБџх)*
T0*
_output_shapes
:	ф
*
seed2в	

variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	ф


variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	ф

s
"variables/truncated_normal_1/shapeConst*
dtype0*
valueB"g  
   *
_output_shapes
:
f
!variables/truncated_normal_1/meanConst*
dtype0*
valueB
 *    *
_output_shapes
: 
h
#variables/truncated_normal_1/stddevConst*
dtype0*
valueB
 *шЁ>*
_output_shapes
: 
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
dtype0*
seedБџх)*
T0*
_output_shapes
:	ч
*
seed2в	
Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	ч


variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	ч


variables/user_factors
VariableV2*
dtype0*
shared_name *
	container *
_output_shapes
:	ф
*
shape:	ф

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	ф
*
validate_shape(*
use_locking(

variables/user_factors/readIdentityvariables/user_factors*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	ф


variables/item_factors
VariableV2*
dtype0*
shared_name *
	container *
_output_shapes
:	ч
*
shape:	ч

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	ч
*
validate_shape(*
use_locking(

variables/item_factors/readIdentityvariables/item_factors*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	ч

^
variables/zerosConst*
dtype0*
valueBч*    *
_output_shapes	
:ч

variables/item_bias
VariableV2*
dtype0*
shared_name *
	container *
_output_shapes	
:ч*
shape:ч
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:ч*
validate_shape(*
use_locking(

variables/item_bias/readIdentityvariables/item_bias*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:ч
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ
*
Tparams0
Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ
*
Tparams0
Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ
*
Tparams0
В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*#
_output_shapes
:џџџџџџџџџ*
Tparams0
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*#
_output_shapes
:џџџџџџџџџ*
Tparams0
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
loss/Sum/reduction_indicesConst*
dtype0*
value	B :*
_output_shapes
: 

loss/SumSumloss/mulloss/Sum/reduction_indices*
T0*#
_output_shapes
:џџџџџџџџџ*

Tidx0*
	keep_dims( 
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
O
loss/SigmoidSigmoidloss/add*
T0*#
_output_shapes
:џџџџџџџџџ
a
loss/clip_by_value/Minimum/yConst*
dtype0*
valueB
 *Єp}?*
_output_shapes
: 

loss/clip_by_value/MinimumMinimumloss/Sigmoidloss/clip_by_value/Minimum/y*
T0*#
_output_shapes
:џџџџџџџџџ
Y
loss/clip_by_value/yConst*
dtype0*
valueB
 *ЌХ'7*
_output_shapes
: 
}
loss/clip_by_valueMaximumloss/clip_by_value/Minimumloss/clip_by_value/y*
T0*#
_output_shapes
:џџџџџџџџџ
Q
loss/LogLogloss/clip_by_value*
T0*#
_output_shapes
:џџџџџџџџџ
T

loss/ConstConst*
dtype0*
valueB: *
_output_shapes
:
e

loss/Sum_1Sumloss/Log
loss/Const*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
O

loss/pow/yConst*
dtype0*
valueB
 *   @*
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
dtype0*
valueB"       *
_output_shapes
:
g

loss/Sum_2Sumloss/powloss/Const_1*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
Q
loss/mul_1/xConst*
dtype0*
valueB
 *
з#<*
_output_shapes
: 
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
dtype0*
valueB
 *   @*
_output_shapes
: 
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_2Const*
dtype0*
valueB"       *
_output_shapes
:
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
Q
loss/mul_2/xConst*
dtype0*
valueB
 *
з#<*
_output_shapes
: 
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
dtype0*
valueB
 *   @*
_output_shapes
: 
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_3Const*
dtype0*
valueB: *
_output_shapes
:
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
J

loss/add_1Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
dtype0*
valueB
 *   @*
_output_shapes
: 
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_4Const*
dtype0*
valueB"       *
_output_shapes
:
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
Q
loss/mul_3/xConst*
dtype0*
valueB
 *
з#<*
_output_shapes
: 
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
dtype0*
valueB
 *   @*
_output_shapes
: 
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_5Const*
dtype0*
valueB: *
_output_shapes
:
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
T0*
_output_shapes
: *

Tidx0*
	keep_dims( 
J

loss/add_2Add
loss/mul_3
loss/Sum_6*
T0*
_output_shapes
: 
J

loss/add_3Add
loss/mul_1
loss/add_1*
T0*
_output_shapes
: 
J

loss/add_4Add
loss/add_3
loss/add_2*
T0*
_output_shapes
: 
J

loss/sub_2Sub
loss/add_4
loss/Sum_1*
T0*
_output_shapes
: 
R
gradients/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
T
gradients/ConstConst*
dtype0*
valueB
 *  ?*
_output_shapes
: 
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/sub_2_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
gradients/loss/add_4_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/add_4_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
_output_shapes
:*
Tshape0
g
gradients/loss/Sum_1_grad/ShapeShapeloss/Log*
T0*
_output_shapes
:*
out_type0
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*

Tmultiples0
b
gradients/loss/add_3_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/add_3_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_3_grad/SumSum2gradients/loss/add_4_grad/tuple/control_dependency/gradients/loss/add_3_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Э
gradients/loss/add_3_grad/Sum_1Sum2gradients/loss/add_4_grad/tuple/control_dependency1gradients/loss/add_3_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
b
gradients/loss/add_2_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/add_2_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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

"gradients/loss/Log_grad/Reciprocal
Reciprocalloss/clip_by_value^gradients/loss/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/Log_grad/mulMulgradients/loss/Sum_1_grad/Tile"gradients/loss/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/mul_1_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/mul_1_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
_output_shapes
: *
Tshape0

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
gradients/loss/add_1_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/add_1_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_1_grad/SumSum4gradients/loss/add_3_grad/tuple/control_dependency_1/gradients/loss/add_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
_output_shapes
: *
Tshape0
Я
gradients/loss/add_1_grad/Sum_1Sum4gradients/loss/add_3_grad/tuple/control_dependency_11gradients/loss/add_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/mul_3_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/mul_3_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
_output_shapes
: *
Tshape0

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
_output_shapes
:*
Tshape0
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
T0*
_output_shapes
:*
out_type0
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*

Tmultiples0

'gradients/loss/clip_by_value_grad/ShapeShapeloss/clip_by_value/Minimum*
T0*
_output_shapes
:*
out_type0
l
)gradients/loss/clip_by_value_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 

)gradients/loss/clip_by_value_grad/Shape_2Shapegradients/loss/Log_grad/mul*
T0*
_output_shapes
:*
out_type0
r
-gradients/loss/clip_by_value_grad/zeros/ConstConst*
dtype0*
valueB
 *    *
_output_shapes
: 
З
'gradients/loss/clip_by_value_grad/zerosFill)gradients/loss/clip_by_value_grad/Shape_2-gradients/loss/clip_by_value_grad/zeros/Const*
T0*#
_output_shapes
:џџџџџџџџџ

.gradients/loss/clip_by_value_grad/GreaterEqualGreaterEqualloss/clip_by_value/Minimumloss/clip_by_value/y*
T0*#
_output_shapes
:џџџџџџџџџ
с
7gradients/loss/clip_by_value_grad/BroadcastGradientArgsBroadcastGradientArgs'gradients/loss/clip_by_value_grad/Shape)gradients/loss/clip_by_value_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
ж
(gradients/loss/clip_by_value_grad/SelectSelect.gradients/loss/clip_by_value_grad/GreaterEqualgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ

,gradients/loss/clip_by_value_grad/LogicalNot
LogicalNot.gradients/loss/clip_by_value_grad/GreaterEqual*#
_output_shapes
:џџџџџџџџџ
ж
*gradients/loss/clip_by_value_grad/Select_1Select,gradients/loss/clip_by_value_grad/LogicalNotgradients/loss/Log_grad/mul'gradients/loss/clip_by_value_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ
Я
%gradients/loss/clip_by_value_grad/SumSum(gradients/loss/clip_by_value_grad/Select7gradients/loss/clip_by_value_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Р
)gradients/loss/clip_by_value_grad/ReshapeReshape%gradients/loss/clip_by_value_grad/Sum'gradients/loss/clip_by_value_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
е
'gradients/loss/clip_by_value_grad/Sum_1Sum*gradients/loss/clip_by_value_grad/Select_19gradients/loss/clip_by_value_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Й
+gradients/loss/clip_by_value_grad/Reshape_1Reshape'gradients/loss/clip_by_value_grad/Sum_1)gradients/loss/clip_by_value_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0

2gradients/loss/clip_by_value_grad/tuple/group_depsNoOp*^gradients/loss/clip_by_value_grad/Reshape,^gradients/loss/clip_by_value_grad/Reshape_1

:gradients/loss/clip_by_value_grad/tuple/control_dependencyIdentity)gradients/loss/clip_by_value_grad/Reshape3^gradients/loss/clip_by_value_grad/tuple/group_deps*<
_class2
0.loc:@gradients/loss/clip_by_value_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

<gradients/loss/clip_by_value_grad/tuple/control_dependency_1Identity+gradients/loss/clip_by_value_grad/Reshape_13^gradients/loss/clip_by_value_grad/tuple/group_deps*>
_class4
20loc:@gradients/loss/clip_by_value_grad/Reshape_1*
T0*
_output_shapes
: 
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
dtype0*
valueB"      *
_output_shapes
:
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
_output_shapes

:*
Tshape0
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
T0*
_output_shapes
:*
out_type0
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
b
gradients/loss/mul_2_grad/ShapeConst*
dtype0*
valueB *
_output_shapes
: 
d
!gradients/loss/mul_2_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_1_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
_output_shapes
: *
Tshape0

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_1_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_1_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
_output_shapes
:*
Tshape0
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
T0*
_output_shapes
:*
out_type0
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*

Tmultiples0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
dtype0*
valueB"      *
_output_shapes
:
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
_output_shapes

:*
Tshape0
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
T0*
_output_shapes
:*
out_type0
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_4_grad/Shape_1Const*
dtype0*
valueB *
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
gradients/loss/pow_4_grad/sub/yConst*
dtype0*
valueB
 *  ?*
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
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
h
#gradients/loss/pow_4_grad/Greater/yConst*
dtype0*
valueB
 *    *
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
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
{
/gradients/loss/clip_by_value/Minimum_grad/ShapeShapeloss/Sigmoid*
T0*
_output_shapes
:*
out_type0
t
1gradients/loss/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Ћ
1gradients/loss/clip_by_value/Minimum_grad/Shape_2Shape:gradients/loss/clip_by_value_grad/tuple/control_dependency*
T0*
_output_shapes
:*
out_type0
z
5gradients/loss/clip_by_value/Minimum_grad/zeros/ConstConst*
dtype0*
valueB
 *    *
_output_shapes
: 
Я
/gradients/loss/clip_by_value/Minimum_grad/zerosFill1gradients/loss/clip_by_value/Minimum_grad/Shape_25gradients/loss/clip_by_value/Minimum_grad/zeros/Const*
T0*#
_output_shapes
:џџџџџџџџџ

3gradients/loss/clip_by_value/Minimum_grad/LessEqual	LessEqualloss/Sigmoidloss/clip_by_value/Minimum/y*
T0*#
_output_shapes
:џџџџџџџџџ
љ
?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs/gradients/loss/clip_by_value/Minimum_grad/Shape1gradients/loss/clip_by_value/Minimum_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

0gradients/loss/clip_by_value/Minimum_grad/SelectSelect3gradients/loss/clip_by_value/Minimum_grad/LessEqual:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ

4gradients/loss/clip_by_value/Minimum_grad/LogicalNot
LogicalNot3gradients/loss/clip_by_value/Minimum_grad/LessEqual*#
_output_shapes
:џџџџџџџџџ

2gradients/loss/clip_by_value/Minimum_grad/Select_1Select4gradients/loss/clip_by_value/Minimum_grad/LogicalNot:gradients/loss/clip_by_value_grad/tuple/control_dependency/gradients/loss/clip_by_value/Minimum_grad/zeros*
T0*#
_output_shapes
:џџџџџџџџџ
ч
-gradients/loss/clip_by_value/Minimum_grad/SumSum0gradients/loss/clip_by_value/Minimum_grad/Select?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
и
1gradients/loss/clip_by_value/Minimum_grad/ReshapeReshape-gradients/loss/clip_by_value/Minimum_grad/Sum/gradients/loss/clip_by_value/Minimum_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
э
/gradients/loss/clip_by_value/Minimum_grad/Sum_1Sum2gradients/loss/clip_by_value/Minimum_grad/Select_1Agradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
б
3gradients/loss/clip_by_value/Minimum_grad/Reshape_1Reshape/gradients/loss/clip_by_value/Minimum_grad/Sum_11gradients/loss/clip_by_value/Minimum_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
Ќ
:gradients/loss/clip_by_value/Minimum_grad/tuple/group_depsNoOp2^gradients/loss/clip_by_value/Minimum_grad/Reshape4^gradients/loss/clip_by_value/Minimum_grad/Reshape_1
В
Bgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependencyIdentity1gradients/loss/clip_by_value/Minimum_grad/Reshape;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*D
_class:
86loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
Ћ
Dgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency_1Identity3gradients/loss/clip_by_value/Minimum_grad/Reshape_1;^gradients/loss/clip_by_value/Minimum_grad/tuple/group_deps*F
_class<
:8loc:@gradients/loss/clip_by_value/Minimum_grad/Reshape_1*
T0*
_output_shapes
: 
g
gradients/loss/pow_grad/ShapeShape
loss/users*
T0*
_output_shapes
:*
out_type0
b
gradients/loss/pow_grad/Shape_1Const*
dtype0*
valueB *
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
gradients/loss/pow_grad/sub/yConst*
dtype0*
valueB
 *  ?*
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
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
f
!gradients/loss/pow_grad/Greater/yConst*
dtype0*
valueB
 *    *
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
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
dtype0*
valueB"      *
_output_shapes
:
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
_output_shapes

:*
Tshape0
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
T0*
_output_shapes
:*
out_type0
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_2_grad/Shape_1Const*
dtype0*
valueB *
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
gradients/loss/pow_2_grad/sub/yConst*
dtype0*
valueB
 *  ?*
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
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
h
#gradients/loss/pow_2_grad/Greater/yConst*
dtype0*
valueB
 *    *
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
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_3_grad/Shape_1Const*
dtype0*
valueB *
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
gradients/loss/pow_3_grad/sub/yConst*
dtype0*
valueB
 *  ?*
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
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
h
#gradients/loss/pow_3_grad/Greater/yConst*
dtype0*
valueB
 *    *
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
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
Ж
'gradients/loss/Sigmoid_grad/SigmoidGradSigmoidGradloss/SigmoidBgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
T0*
_output_shapes
:*
out_type0
d
!gradients/loss/pow_1_grad/Shape_1Const*
dtype0*
valueB *
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
gradients/loss/pow_1_grad/sub/yConst*
dtype0*
valueB
 *  ?*
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
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
h
#gradients/loss/pow_1_grad/Greater/yConst*
dtype0*
valueB
 *    *
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
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
_output_shapes
: *
Tshape0
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
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
T0*
_output_shapes
:*
out_type0
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
T0*
_output_shapes
:*
out_type0
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
К
gradients/loss/add_grad/SumSum'gradients/loss/Sigmoid_grad/SigmoidGrad-gradients/loss/add_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
О
gradients/loss/add_grad/Sum_1Sum'gradients/loss/Sigmoid_grad/SigmoidGrad/gradients/loss/add_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
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
T0*
_output_shapes
:*
out_type0
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
T0*
_output_shapes
:*
out_type0
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
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
T0*
_output_shapes
:*
out_type0
^
gradients/loss/Sum_grad/SizeConst*
dtype0*
value	B :*
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
gradients/loss/Sum_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/startConst*
dtype0*
value	B : *
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/deltaConst*
dtype0*
value	B :*
_output_shapes
: 
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
dtype0*
value	B :*
_output_shapes
: 

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
T0*#
_output_shapes
:џџџџџџџџџ*
N
c
!gradients/loss/Sum_grad/Maximum/yConst*
dtype0*
value	B :*
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
T0*
_output_shapes
:*
Tshape0
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*'
_output_shapes
:џџџџџџџџџ
*

Tmultiples0
ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ*
N

'gradients/loss/pos_item_bias_grad/ShapeConst*
dtype0*
valueB:ч*
_output_shapes
:*&
_class
loc:@variables/item_bias

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
_output_shapes
: *
out_type0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
dtype0*
value	B : *
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
5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
dtype0*
valueB:*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
dtype0*
valueB: *
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
dtype0*
valueB:*
_output_shapes
:
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
: 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
dtype0*
value	B : *
_output_shapes
: 
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ*
N

'gradients/loss/neg_item_bias_grad/ShapeConst*
dtype0*
valueB:ч*
_output_shapes
:*&
_class
loc:@variables/item_bias

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
_output_shapes
: *
out_type0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
dtype0*
value	B : *
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
5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
dtype0*
valueB:*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
dtype0*
valueB: *
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
dtype0*
valueB:*
_output_shapes
:
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
: 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
dtype0*
value	B : *
_output_shapes
: 
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
g
gradients/loss/mul_grad/ShapeShape
loss/users*
T0*
_output_shapes
:*
out_type0
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
T0*
_output_shapes
:*
out_type0
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
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0

gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
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
gradients/concat/axisConst*
dtype0*
value	B : *
_output_shapes
: 
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
Y
gradients/concat_1/axisConst*
dtype0*
value	B : *
_output_shapes
: 
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ
*
N

gradients/loss/users_grad/ShapeConst*
dtype0*
valueB"d  
   *
_output_shapes
:*)
_class
loc:@variables/user_factors
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
T0*
_output_shapes
: *
out_type0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
dtype0*
value	B : *
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
-gradients/loss/users_grad/strided_slice/stackConst*
dtype0*
valueB:*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
dtype0*
valueB: *
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
dtype0*
valueB:*
_output_shapes
:
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
:
g
%gradients/loss/users_grad/concat/axisConst*
dtype0*
value	B : *
_output_shapes
: 
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
Tshape0
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
T0*
_output_shapes
:*
out_type0
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
T0*
_output_shapes
:*
out_type0
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
T0*
_output_shapes
:*

Tidx0*
	keep_dims( 
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*'
_output_shapes
:џџџџџџџџџ
*
Tshape0
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
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ
*
N

#gradients/loss/pos_items_grad/ShapeConst*
dtype0*
valueB"g  
   *
_output_shapes
:*)
_class
loc:@variables/item_factors
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
_output_shapes
: *
out_type0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
dtype0*
value	B : *
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
1gradients/loss/pos_items_grad/strided_slice/stackConst*
dtype0*
valueB:*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
dtype0*
valueB: *
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
dtype0*
valueB:*
_output_shapes
:

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
:
k
)gradients/loss/pos_items_grad/concat/axisConst*
dtype0*
value	B : *
_output_shapes
: 
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
Tshape0
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ
*
N

#gradients/loss/neg_items_grad/ShapeConst*
dtype0*
valueB"g  
   *
_output_shapes
:*)
_class
loc:@variables/item_factors
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
_output_shapes
: *
out_type0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
dtype0*
value	B : *
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
1gradients/loss/neg_items_grad/strided_slice/stackConst*
dtype0*
valueB:*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
dtype0*
valueB: *
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
dtype0*
valueB:*
_output_shapes
:

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
T0*
Index0*
ellipsis_mask *
end_mask*

begin_mask *
new_axis_mask *
_output_shapes
:
k
)gradients/loss/neg_items_grad/concat/axisConst*
dtype0*
value	B : *
_output_shapes
: 
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
Tshape0
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*#
_output_shapes
:џџџџџџџџџ*
Tshape0
Y
gradients/concat_2/axisConst*
dtype0*
value	B : *
_output_shapes
: 
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
N*

Tidx0
Y
gradients/concat_3/axisConst*
dtype0*
value	B : *
_output_shapes
: 
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
b
GradientDescent/learning_rateConst*
dtype0*
valueB
 *ЭЬЬ=*
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
Tindices0*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	ф
*
use_locking( 
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
Tindices0*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	ч
*
use_locking( 
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
Tindices0*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:ч*
use_locking( 
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
dtype0*
valueB Bloss_1*
_output_shapes
: 
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign""
train_op

GradientDescent"
	variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0" 
trainable_variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0"
	summaries


loss_1:0КF       и-	јЅє]жA*

loss_1JЮC,р       ШС	рїє]жA*

loss_1чC§ідФ       ШС	цє]жA*

loss_1д	CФШы       ШС	Jє]жA*

loss_1ё	C=4ќ       ШС	mtє]жA*

loss_1erCК5`Њ       ШС	ђє]жA*

loss_1|C;ђўЫ       ШС	Нє]жA*

loss_1@	CЕк       ШС	Zє]жA*

loss_1:C=nр       ШС	=є]жA*

loss_1yCЃHЊ       ШС	є]жA	*

loss_13і	CЧХс       ШС	є]жA
*

loss_1ciCЏщЯ       ШС	Oє]жA*

loss_1ћ9CРA58       ШС	/Ј є]жA*

loss_1ПU	CdЊЪ8       ШС	ЯјЁє]жA*

loss_1CР_ёј       ШС	+4Ѓє]жA*

loss_1lDCњЂ4       ШС	?Єє]жA*

loss_1WCЋў       ШС	ПЅє]жA*

loss_1
CvР       ШС	ЙЇє]жA*

loss_1uUC4ЖQЊ       ШС	=`Јє]жA*

loss_1­CБ'Њ       ШС	-ЯЉє]жA*

loss_1љЩC,Є"       ШС	Ћє]жA*

loss_1CЈkэ       ШС	)@Ќє]жA*

loss_1ГПCmsј       ШС	n­є]жA*

loss_1ярCйчб       ШС	АЧЎє]жA*

loss_1+/
C7r­ц       ШС	xюЏє]жA*

loss_1~,CЕВ       ШС	Ж0Бє]жA*

loss_1ј	CWa       ШС	ЦoВє]жA*

loss_1xCЅЪѓ       ШС	yГє]жA*

loss_1sCњyP[       ШС	№Дє]жA*

loss_1
C17Ђl       ШС	!Жє]жA*

loss_1VCШіw/       ШС	sJЗє]жA*

loss_1ЧЏ C?2Ў       ШС	ЄoИє]жA*

loss_1!нCпІђ       ШС	БЙє]жA *

loss_1юCwіІh       ШС	БКє]жA!*

loss_1ЌCфДо       ШС	:Мє]жA"*

loss_1|G CЯ92       ШС	Ж/Нє]жA#*

loss_1C7F\(       ШС	?RОє]жA$*

loss_1еФCІ%ИЁ       ШС	Пє]жA%*

loss_1п}CЖaO       ШС	eІРє]жA&*

loss_1бC	ћШS       ШС	ЕССє]жA'*

loss_1CEKB       ШС	gУє]жA(*

loss_1C>ё       ШС	@Фє]жA)*

loss_1к[CАщO       ШС	VХє]жA**

loss_1фЯCgP6T       ШС	zЦє]жA+*

loss_1ЗШњBќ@ач       ШС	}­Чє]жA,*

loss_1вP C№
       ШС	лШє]жA-*

loss_1CQжу       ШС	Р%Ъє]жA.*

loss_1J Cѕїnб       ШС	!YЫє]жA/*

loss_1`AџB3=AF       ШС	уЬє]жA0*

loss_1*j§B}эB       ШС	ЪЭє]жA1*

loss_1эхћBУё       ШС	Яє]жA2*

loss_1
]љB=п       ШС	?ає]жA3*

loss_1єѕB№:с       ШС	aбє]жA4*

loss_1v&њB_cма       ШС	iШвє]жA5*

loss_1ЖАёBБџр       ШС	.дє]жA6*

loss_1яћB№CW=       ШС	Kеє]жA7*

loss_1jёB!Мv       ШС	lzжє]жA8*

loss_1FѕBmAц       ШС	Узє]жA9*

loss_1Ъ&ёBp4ў       ШС	uйє]жA:*

loss_1е>ђBЭ ѓ       ШС	_^кє]жA;*

loss_10lёBОП~       ШС	лє]жA<*

loss_1-3ыB*k\       ШС	nОмє]жA=*

loss_1тBДt       ШС	Xцнє]жA>*

loss_1ѕСђBц^B       ШС	4пє]жA?*

loss_1чB< s       ШС	Lmрє]жA@*

loss_1vшяBЅpП       ШС	сє]жAA*

loss_1/MзBN       ШС	эМтє]жAB*

loss_1П№тBя       ШС	mтує]жAC*

loss_1ВtоB`;щб       ШС	хє]жAD*

loss_1$кBZ8ч       ШС	ь3цє]жAE*

loss_1|WоBSЬХ       ШС	чє]жAF*

loss_1ъDбBаXЗ       ШС	ГЕшє]жAG*

loss_1лЮBэм2}       ШС	ижщє]жAH*

loss_1`ЮB[%щ       ШС	$ыє]жAI*

loss_1NаBЩiA       ШС	Є7ьє]жAJ*

loss_1.ювBsИ        ШС	&Wэє]жAK*

loss_1Т~УBљжу8       ШС	Іює]жAL*

loss_1№jдB~ё       ШС	мдяє]жAM*

loss_1Ф`ЮB№п7*       ШС	Ю§№є]жAN*

loss_1р|ЧBыЗЙЛ       ШС	З%ђє]жAO*

loss_1<ЫB#йУ       ШС	љJѓє]жAP*

loss_1ъWЛBњXy       ШС	ћtєє]жAQ*

loss_1dНBЧI       ШС	Ьдѕє]жAR*

loss_1љЩBИ&Pv       ШС	Нїє]жAS*

loss_1ЪBa       ШС	ЏDјє]жAT*

loss_1*ШЪBТ2<3       ШС	Юmљє]жAU*

loss_1`ЋИB8ЈF       ШС	Ўњє]жAV*

loss_1
"ДB Љ|       ШС	Нћє]жAW*

loss_1j#ВBиЙК       ШС	2§є]жAX*

loss_1ЙBэЃЊ       ШС	Э[ўє]жAY*

loss_1ёRОB#4       ШС	џє]жAZ*

loss_1ТB@є=       ШС	дК є]жA[*

loss_1
tСBrЇњІ       ШС	Зэє]жA\*

loss_1pЏBECлB       ШС	qє]жA]*

loss_1Л]ЏB(І       ШС	-wє]жA^*

loss_1ЯЄЗBD/}       ШС	Йє]жA_*

loss_1фл­BоЈ        ШС	Оіє]жA`*

loss_1\(ЂBь8d       ШС	3є]жAa*

loss_1ІG­BdИЕ       ШС	-[	є]жAb*

loss_13dАBэ%МО       ШС	0
є]жAc*

loss_1Њ3ГBцВЄР       ШС	Цнє]жAd*

loss_1
ЇBь9Ђ       ШС	є]жAe*

loss_1{ЏBФлD       ШС	№0є]жAf*

loss_1ѕjЈBC"       ШС	gє]жAg*

loss_1уЗBй4Ы       ШС	3є]жAh*

loss_1Z By@       ШС	Ђє]жAi*

loss_1НкЂB0,хЮ       ШС	<њє]жAj*

loss_1іBјаY       ШС	8.є]жAk*

loss_1ІBp`ш/       ШС	оUє]жAl*

loss_12ЉBBi       ШС	~є]жAm*

loss_1ЈBёb*=       ШС	ЉМє]жAn*

loss_1{ЄBю№!       ШС	Lрє]жAo*

loss_1&РBез4       ШС	7є]жAp*

loss_1пЁBЅDу       ШС	Тhє]жAq*

loss_1bІBжm4       ШС	є]жAr*

loss_1§ЌBяKЂw       ШС	MКє]жAs*

loss_1ф[BћЇIц       ШС	оє]жAt*

loss_1\ІB|^7Ь       ШС	 
 є]жAu*

loss_1ЈB)јL       ШС	ХS!є]жAv*

loss_1ЂpІB:ы<I       ШС	"є]жAw*

loss_1дїB_       ШС	6­#є]жAx*

loss_1=B1|Щ>       ШС	ЇЬ$є]жAy*

loss_1PЩBњjє        ШС	Gщ%є]жAz*

loss_1-ЧBФњ       ШС	§'є]жA{*

loss_1BЯЧL       ШС	)_(є]жA|*

loss_1бЋЊBosЏ       ШС	2)є]жA}*

loss_1OЁBД
ы       ШС	К*є]жA~*

loss_1нкB`ёЗу       ШС	сё+є]жA*

loss_1m<Bъ:Эћ       `/п#	я-є]жA*

loss_1ЕBUф       `/п#	ЯL.є]жA*

loss_1
џBA­Вч       `/п#	9И/є]жA*

loss_1$iBQs       `/п#	ў0є]жA*

loss_1{B`yм       `/п#	)#2є]жA*

loss_11Bаc{{       `/п#	ГD3є]жA*

loss_1ЊIBjК&Х       `/п#	 a4є]жA*

loss_1fлBО}.       `/п#	]5є]жA*

loss_1BмКhх       `/п#	sз6є]жA*

loss_1пћBEИчW       `/п#	8є]жA*

loss_1­ДB\ ё       `/п#	cG9є]жA*

loss_1P7Bzj%       `/п#	z:є]жA*

loss_1РB<c§       `/п#	Ў;є]жA*

loss_1iBn§)J       `/п#	њд<є]жA*

loss_1ЯBЙНѓ       `/п#	ѕ/>є]жA*

loss_1ЄЂBzJ"М       `/п#	щc?є]жA*

loss_1кмBGЗE-       `/п#	I@є]жA*

loss_1_+B\Y4       `/п#	'НAє]жA*

loss_1:BИ#       `/п#	јоBє]жA*

loss_1EBЭ       `/п#	вўCє]жA*

loss_16\BTЈ"       `/п#	fgEє]жA*

loss_1vjBьж3       `/п#	ШFє]жA*

loss_1PBрUv