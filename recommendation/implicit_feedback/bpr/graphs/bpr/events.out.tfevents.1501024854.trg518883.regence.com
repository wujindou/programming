       ЃK"	  є]жAbrain.Event:2Iп+ѕh'     /$	Ёє]жA"лЮ
h
placeholders/sampled_usersPlaceholder*
shape: *
dtype0*#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_pos_itemsPlaceholder*
shape: *
dtype0*#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_neg_itemsPlaceholder*
shape: *
dtype0*#
_output_shapes
:џџџџџџџџџ
q
 variables/truncated_normal/shapeConst*
dtype0*
valueB"  
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
_output_shapes
:	
*
seedБџх)*
dtype0*
seed2в	*
T0
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
dtype0*
valueB"m  
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
_output_shapes
:	э
*
seedБџх)*
dtype0*
seed2в	*
T0
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
	container *
shape:	
*
dtype0*
shared_name *
_output_shapes
:	

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
_output_shapes
:	
*)
_class
loc:@variables/user_factors*
T0*
use_locking(*
validate_shape(
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
	container *
shape:	э
*
dtype0*
shared_name *
_output_shapes
:	э

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
_output_shapes
:	э
*)
_class
loc:@variables/item_factors*
T0*
use_locking(*
validate_shape(

variables/item_factors/readIdentityvariables/item_factors*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	э

^
variables/zerosConst*
dtype0*
valueBэ*    *
_output_shapes	
:э

variables/item_bias
VariableV2*
	container *
shape:э*
dtype0*
shared_name *
_output_shapes	
:э
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
_output_shapes	
:э*&
_class
loc:@variables/item_bias*
T0*
use_locking(*
validate_shape(

variables/item_bias/readIdentityvariables/item_bias*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:э
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tparams0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0
Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tparams0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0
Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tparams0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0
В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tparams0*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tparams0*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0
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
loss/SumSumloss/mulloss/Sum/reduction_indices*#
_output_shapes
:џџџџџџџџџ*

Tidx0*
	keep_dims( *
T0
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
loss/Const*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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

loss/Sum_2Sumloss/powloss/Const_1*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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
loss/pow_1loss/Const_2*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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
loss/pow_2loss/Const_3*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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
loss/pow_3loss/Const_4*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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
loss/pow_4loss/Const_5*
_output_shapes
: *

Tidx0*
	keep_dims( *
T0
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
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
Tshape0*
T0*
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
gradients/loss/add_4_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
Tshape0*
T0*
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
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes
:
g
gradients/loss/Sum_1_grad/ShapeShapeloss/Log*
out_type0*
T0*
_output_shapes
:
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*

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
gradients/loss/add_3_grad/SumSum2gradients/loss/add_4_grad/tuple/control_dependency/gradients/loss/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Э
gradients/loss/add_3_grad/Sum_1Sum2gradients/loss/add_4_grad/tuple/control_dependency1gradients/loss/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
Tshape0*
T0*
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
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
Tshape0*
T0*
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
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
Tshape0*
T0*
_output_shapes
: 

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
Tshape0*
T0*
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
gradients/loss/add_1_grad/SumSum4gradients/loss/add_3_grad/tuple/control_dependency_1/gradients/loss/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Я
gradients/loss/add_1_grad/Sum_1Sum4gradients/loss/add_3_grad/tuple/control_dependency_11gradients/loss/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
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
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
Tshape0*
T0*
_output_shapes
: 

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
Tshape0*
T0*
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
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes
:
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
out_type0*
T0*
_output_shapes
:
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*

Tmultiples0

'gradients/loss/clip_by_value_grad/ShapeShapeloss/clip_by_value/Minimum*
out_type0*
T0*
_output_shapes
:
l
)gradients/loss/clip_by_value_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 

)gradients/loss/clip_by_value_grad/Shape_2Shapegradients/loss/Log_grad/mul*
out_type0*
T0*
_output_shapes
:
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
%gradients/loss/clip_by_value_grad/SumSum(gradients/loss/clip_by_value_grad/Select7gradients/loss/clip_by_value_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Р
)gradients/loss/clip_by_value_grad/ReshapeReshape%gradients/loss/clip_by_value_grad/Sum'gradients/loss/clip_by_value_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
е
'gradients/loss/clip_by_value_grad/Sum_1Sum*gradients/loss/clip_by_value_grad/Select_19gradients/loss/clip_by_value_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Й
+gradients/loss/clip_by_value_grad/Reshape_1Reshape'gradients/loss/clip_by_value_grad/Sum_1)gradients/loss/clip_by_value_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
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
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes

:
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
out_type0*
T0*
_output_shapes
:
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*'
_output_shapes
:џџџџџџџџџ
*
T0*

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
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
Tshape0*
T0*
_output_shapes
: 

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_1_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
Tshape0*
T0*
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
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_1_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes
:
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
out_type0*
T0*
_output_shapes
:
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*

Tmultiples0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
dtype0*
valueB"      *
_output_shapes
:
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes

:
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
out_type0*
T0*
_output_shapes
:
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*'
_output_shapes
:џџџџџџџџџ
*
T0*

Tmultiples0
q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
out_type0*
T0*
_output_shapes
:
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
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
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
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
Tshape0*
T0*
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
{
/gradients/loss/clip_by_value/Minimum_grad/ShapeShapeloss/Sigmoid*
out_type0*
T0*
_output_shapes
:
t
1gradients/loss/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Ћ
1gradients/loss/clip_by_value/Minimum_grad/Shape_2Shape:gradients/loss/clip_by_value_grad/tuple/control_dependency*
out_type0*
T0*
_output_shapes
:
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
-gradients/loss/clip_by_value/Minimum_grad/SumSum0gradients/loss/clip_by_value/Minimum_grad/Select?gradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
и
1gradients/loss/clip_by_value/Minimum_grad/ReshapeReshape-gradients/loss/clip_by_value/Minimum_grad/Sum/gradients/loss/clip_by_value/Minimum_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
э
/gradients/loss/clip_by_value/Minimum_grad/Sum_1Sum2gradients/loss/clip_by_value/Minimum_grad/Select_1Agradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
б
3gradients/loss/clip_by_value/Minimum_grad/Reshape_1Reshape/gradients/loss/clip_by_value/Minimum_grad/Sum_11gradients/loss/clip_by_value/Minimum_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
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
loss/users*
out_type0*
T0*
_output_shapes
:
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
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

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
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
Tshape0*
T0*
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
dtype0*
valueB"      *
_output_shapes
:
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes

:
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
out_type0*
T0*
_output_shapes
:
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*'
_output_shapes
:џџџџџџџџџ
*
T0*

Tmultiples0
q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
out_type0*
T0*
_output_shapes
:
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
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
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
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
Tshape0*
T0*
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
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
out_type0*
T0*
_output_shapes
:
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
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

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
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
Tshape0*
T0*
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
Ж
'gradients/loss/Sigmoid_grad/SigmoidGradSigmoidGradloss/SigmoidBgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
out_type0*
T0*
_output_shapes
:
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
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

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
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
Tshape0*
T0*
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
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
out_type0*
T0*
_output_shapes
:
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
out_type0*
T0*
_output_shapes
:
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
К
gradients/loss/add_grad/SumSum'gradients/loss/Sigmoid_grad/SigmoidGrad-gradients/loss/add_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
О
gradients/loss/add_grad/Sum_1Sum'gradients/loss/Sigmoid_grad/SigmoidGrad/gradients/loss/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
Tshape0*
T0*#
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
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
out_type0*
T0*
_output_shapes
:
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
out_type0*
T0*
_output_shapes
:
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
Tshape0*
T0*#
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
gradients/loss/Sum_grad/ShapeShapeloss/mul*
out_type0*
T0*
_output_shapes
:
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
N*
T0*#
_output_shapes
:џџџџџџџџџ
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
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
Tshape0*
T0*
_output_shapes
:
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*'
_output_shapes
:џџџџџџџџџ
*
T0*

Tmultiples0
ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/pos_item_bias_grad/ShapeConst*
valueB:э*
dtype0*&
_class
loc:@variables/item_bias*
_output_shapes
:

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
T0*
_output_shapes
: 
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
_output_shapes
: *
new_axis_mask *
shrink_axis_mask 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
dtype0*
value	B : *
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
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
Tshape0*
T0*#
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
'gradients/loss/neg_item_bias_grad/ShapeConst*
valueB:э*
dtype0*&
_class
loc:@variables/item_bias*
_output_shapes
:

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
T0*
_output_shapes
: 
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
_output_shapes
: *
new_axis_mask *
shrink_axis_mask 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
dtype0*
value	B : *
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
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/mul_grad/ShapeShape
loss/users*
out_type0*
T0*
_output_shapes
:
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
out_type0*
T0*
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
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
Tshape0*
T0*'
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
gradients/concat/axisConst*
dtype0*
value	B : *
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
gradients/concat_1/axisConst*
dtype0*
value	B : *
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
gradients/loss/users_grad/ShapeConst*
valueB"  
   *
dtype0*)
_class
loc:@variables/user_factors*
_output_shapes
:
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
out_type0*
T0*
_output_shapes
: 
j
(gradients/loss/users_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
_output_shapes
:*
new_axis_mask *
shrink_axis_mask 
g
%gradients/loss/users_grad/concat/axisConst*
dtype0*
value	B : *
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
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
Tshape0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
out_type0*
T0*
_output_shapes
:
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
out_type0*
T0*
_output_shapes
:
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
_output_shapes
:*

Tidx0*
	keep_dims( *
T0
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
Tshape0*
T0*'
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
#gradients/loss/pos_items_grad/ShapeConst*
valueB"m  
   *
dtype0*)
_class
loc:@variables/item_factors*
_output_shapes
:
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
T0*
_output_shapes
: 
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
_output_shapes
:*
new_axis_mask *
shrink_axis_mask 
k
)gradients/loss/pos_items_grad/concat/axisConst*
dtype0*
value	B : *
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
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
Tshape0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
Tshape0*
T0*#
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
#gradients/loss/neg_items_grad/ShapeConst*
valueB"m  
   *
dtype0*)
_class
loc:@variables/item_factors*
_output_shapes
:
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
T0*
_output_shapes
: 
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
_output_shapes
:*
new_axis_mask *
shrink_axis_mask 
k
)gradients/loss/neg_items_grad/concat/axisConst*
dtype0*
value	B : *
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
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
Tshape0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_2/axisConst*
dtype0*
value	B : *
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
gradients/concat_3/axisConst*
dtype0*
value	B : *
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
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
_output_shapes
:	
*)
_class
loc:@variables/user_factors*
T0*
use_locking( *
Tindices0
б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*)
_class
loc:@variables/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
_output_shapes
:	э
*)
_class
loc:@variables/item_factors*
T0*
use_locking( *
Tindices0
М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*&
_class
loc:@variables/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
_output_shapes	
:э*&
_class
loc:@variables/item_bias*
T0*
use_locking( *
Tindices0
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
Merge/MergeSummaryMergeSummaryloss_1*
N*
_output_shapes
: 
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign"u2юF7     	иЃш	нІє]жAJЙю
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
shape: *
dtype0*#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_pos_itemsPlaceholder*
shape: *
dtype0*#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_neg_itemsPlaceholder*
shape: *
dtype0*#
_output_shapes
:џџџџџџџџџ
q
 variables/truncated_normal/shapeConst*
dtype0*
valueB"  
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
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
T0*
seedБџх)*
dtype0*
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
dtype0*
valueB"m  
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
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
T0*
seedБџх)*
dtype0*
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
	container *
shape:	
*
dtype0*
shared_name *
_output_shapes
:	

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
validate_shape(*)
_class
loc:@variables/user_factors*
T0*
use_locking(*
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
	container *
shape:	э
*
dtype0*
shared_name *
_output_shapes
:	э

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
validate_shape(*)
_class
loc:@variables/item_factors*
T0*
use_locking(*
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
variables/zerosConst*
dtype0*
valueBэ*    *
_output_shapes	
:э

variables/item_bias
VariableV2*
	container *
shape:э*
dtype0*
shared_name *
_output_shapes	
:э
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
validate_shape(*&
_class
loc:@variables/item_bias*
T0*
use_locking(*
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

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tparams0*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ

Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tparams0*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ

Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tparams0*
Tindices0*
validate_indices(*'
_output_shapes
:џџџџџџџџџ

В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tparams0*
Tindices0*
validate_indices(*#
_output_shapes
:џџџџџџџџџ
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tparams0*
Tindices0*
validate_indices(*#
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
loss/Sum/reduction_indicesConst*
dtype0*
value	B :*
_output_shapes
: 

loss/SumSumloss/mulloss/Sum/reduction_indices*
T0*

Tidx0*
	keep_dims( *#
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
: 
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
: 
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
: 
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
: 
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
: 
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
: 
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
Tshape0*
T0*
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
Tshape0*
T0*
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
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes
:
g
gradients/loss/Sum_1_grad/ShapeShapeloss/Log*
out_type0*
T0*
_output_shapes
:
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Э
gradients/loss/add_3_grad/Sum_1Sum2gradients/loss/add_4_grad/tuple/control_dependency1gradients/loss/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
Tshape0*
T0*
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
Tshape0*
T0*
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
Tshape0*
T0*
_output_shapes
: 

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
Tshape0*
T0*
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
Tshape0*
T0*
_output_shapes
: 
Я
gradients/loss/add_1_grad/Sum_1Sum4gradients/loss/add_3_grad/tuple/control_dependency_11gradients/loss/add_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
Tshape0*
T0*
_output_shapes
: 

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
Tshape0*
T0*
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
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes
:
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
out_type0*
T0*
_output_shapes
:
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/clip_by_value_grad/ShapeShapeloss/clip_by_value/Minimum*
out_type0*
T0*
_output_shapes
:
l
)gradients/loss/clip_by_value_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 

)gradients/loss/clip_by_value_grad/Shape_2Shapegradients/loss/Log_grad/mul*
out_type0*
T0*
_output_shapes
:
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Р
)gradients/loss/clip_by_value_grad/ReshapeReshape%gradients/loss/clip_by_value_grad/Sum'gradients/loss/clip_by_value_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
е
'gradients/loss/clip_by_value_grad/Sum_1Sum*gradients/loss/clip_by_value_grad/Select_19gradients/loss/clip_by_value_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Й
+gradients/loss/clip_by_value_grad/Reshape_1Reshape'gradients/loss/clip_by_value_grad/Sum_1)gradients/loss/clip_by_value_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
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
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes

:
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
out_type0*
T0*
_output_shapes
:
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
Tshape0*
T0*
_output_shapes
: 

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_1_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
Tshape0*
T0*
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
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
dtype0*
valueB:*
_output_shapes
:
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_1_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes
:
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
out_type0*
T0*
_output_shapes
:
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
dtype0*
valueB"      *
_output_shapes
:
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes

:
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
out_type0*
T0*
_output_shapes
:
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
out_type0*
T0*
_output_shapes
:
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
Tshape0*
T0*
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
{
/gradients/loss/clip_by_value/Minimum_grad/ShapeShapeloss/Sigmoid*
out_type0*
T0*
_output_shapes
:
t
1gradients/loss/clip_by_value/Minimum_grad/Shape_1Const*
dtype0*
valueB *
_output_shapes
: 
Ћ
1gradients/loss/clip_by_value/Minimum_grad/Shape_2Shape:gradients/loss/clip_by_value_grad/tuple/control_dependency*
out_type0*
T0*
_output_shapes
:
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
и
1gradients/loss/clip_by_value/Minimum_grad/ReshapeReshape-gradients/loss/clip_by_value/Minimum_grad/Sum/gradients/loss/clip_by_value/Minimum_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
э
/gradients/loss/clip_by_value/Minimum_grad/Sum_1Sum2gradients/loss/clip_by_value/Minimum_grad/Select_1Agradients/loss/clip_by_value/Minimum_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
б
3gradients/loss/clip_by_value/Minimum_grad/Reshape_1Reshape/gradients/loss/clip_by_value/Minimum_grad/Sum_11gradients/loss/clip_by_value/Minimum_grad/Shape_1*
Tshape0*
T0*
_output_shapes
: 
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
loss/users*
out_type0*
T0*
_output_shapes
:
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
Tshape0*
T0*
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
dtype0*
valueB"      *
_output_shapes
:
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
Tshape0*
T0*
_output_shapes

:
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
out_type0*
T0*
_output_shapes
:
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
out_type0*
T0*
_output_shapes
:
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
Tshape0*
T0*
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
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
out_type0*
T0*
_output_shapes
:
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
Tshape0*
T0*
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
Ж
'gradients/loss/Sigmoid_grad/SigmoidGradSigmoidGradloss/SigmoidBgradients/loss/clip_by_value/Minimum_grad/tuple/control_dependency*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
out_type0*
T0*
_output_shapes
:
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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

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
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
Tshape0*
T0*
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
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
out_type0*
T0*
_output_shapes
:
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
out_type0*
T0*
_output_shapes
:
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
К
gradients/loss/add_grad/SumSum'gradients/loss/Sigmoid_grad/SigmoidGrad-gradients/loss/add_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
О
gradients/loss/add_grad/Sum_1Sum'gradients/loss/Sigmoid_grad/SigmoidGrad/gradients/loss/add_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
Tshape0*
T0*#
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
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
out_type0*
T0*
_output_shapes
:
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
out_type0*
T0*
_output_shapes
:
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
Tshape0*
T0*#
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
gradients/loss/Sum_grad/ShapeShapeloss/mul*
out_type0*
T0*
_output_shapes
:
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
N*
T0*#
_output_shapes
:џџџџџџџџџ
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
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
Tshape0*
T0*
_output_shapes
:
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*
T0*'
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
loc:@variables/item_bias*
dtype0*
valueB:э*
_output_shapes
:

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
T0*
_output_shapes
: 
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
shrink_axis_mask *
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
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
N*

Tidx0*
T0*
_output_shapes
:
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
Tshape0*
T0*#
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
loc:@variables/item_bias*
dtype0*
valueB:э*
_output_shapes
:

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
T0*
_output_shapes
: 
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
shrink_axis_mask *
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
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
N*

Tidx0*
T0*
_output_shapes
:
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/mul_grad/ShapeShape
loss/users*
out_type0*
T0*
_output_shapes
:
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
out_type0*
T0*
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
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
Tshape0*
T0*'
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
gradients/concat/axisConst*
dtype0*
value	B : *
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
gradients/concat_1/axisConst*
dtype0*
value	B : *
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
dtype0*
valueB"  
   *
_output_shapes
:
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
out_type0*
T0*
_output_shapes
: 
j
(gradients/loss/users_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
shrink_axis_mask *
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
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
N*

Tidx0*
T0*
_output_shapes
:
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
Tshape0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
out_type0*
T0*
_output_shapes
:
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
out_type0*
T0*
_output_shapes
:
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
Tshape0*
T0*'
_output_shapes
:џџџџџџџџџ

Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
	keep_dims( *
_output_shapes
:
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
Tshape0*
T0*'
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
dtype0*
valueB"m  
   *
_output_shapes
:
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
T0*
_output_shapes
: 
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
shrink_axis_mask *
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
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
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
Tshape0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
Tshape0*
T0*#
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
dtype0*
valueB"m  
   *
_output_shapes
:
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
T0*
_output_shapes
: 
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
dtype0*
value	B : *
_output_shapes
: 
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*

Tdim0*
T0*
_output_shapes
:
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
shrink_axis_mask *
ellipsis_mask *

begin_mask *
T0*
Index0*
end_mask*
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
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
Tshape0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
Tshape0*
T0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_2/axisConst*
dtype0*
value	B : *
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
gradients/concat_3/axisConst*
dtype0*
value	B : *
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
T0*
use_locking( *
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
Tindices0*)
_class
loc:@variables/item_factors*
T0*
use_locking( *
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
Tindices0*&
_class
loc:@variables/item_bias*
T0*
use_locking( *
_output_shapes	
:э
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
Merge/MergeSummaryMergeSummaryloss_1*
N*
_output_shapes
: 
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign""
train_op

GradientDescent" 
trainable_variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0"
	summaries


loss_1:0"
	variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0f]       и-	8ЛЈє]жA*

loss_1ЯCk^!u       ШС	jОЉє]жA*

loss_1MСCr'м       ШС	ЋЊє]жA*

loss_1	зCЪx6ђ       ШС	fЋє]жA*

loss_1їCrm4<       ШС	ffЌє]жA*

loss_1QњCIА       ШС	:­є]жA*

loss_1s§Cџйжо       ШС	ЏЎє]жA*

loss_1ЙCи?u       ШС	яЎє]жA*

loss_1@cClВ       ШС	ЮрЏє]жA*

loss_1мНCЧж	       ШС	­лАє]жA	*

loss_1(Cь№       ШС	ЕБє]жA
*

loss_1{MC АН       ШС	Вє]жA*

loss_1Љу	C)h       ШС	OГє]жA*

loss_18$Cб3Ўљ       ШС	!Дє]жA*

loss_1Л	CCя       ШС	йэДє]жA*

loss_1\C#-Эf       ШС	8ЛЕє]жA*

loss_1ЕCе       ШС	їЖє]жA*

loss_1~CЋ:q       ШС	кЗє]жA*

loss_1T=Cny       ШС	FxИє]жA*

loss_1БўBBMД       ШС	UЙє]жA*

loss_1 &CbЂ­       ШС	!ZКє]жA*

loss_1bњB
є^       ШС	йBЛє]жA*

loss_1шМCa       ШС	0*Мє]жA*

loss_1ЄCЋ­С:       ШС	'Нє]жA*

loss_1г+CJіу       ШС	?Оє]жA*

loss_1?c CщЕ       ШС	г-Пє]жA*

loss_1иѓCб{       ШС	ЛEРє]жA*

loss_1|ЩћBЇ§Ё       ШС	tFСє]жA*

loss_1ўBU{       ШС	1Тє]жA*

loss_1JCЌe*	       ШС	Ё/Ує]жA*

loss_1э`іB9Ъшk       ШС	*Фє]жA*

loss_1н~ќB<ЉG~       ШС	ыХє]жA*

loss_1ЛъћB3ЯP       ШС	й
Цє]жA *

loss_1ѓЅљB3уG       ШС	§њЦє]жA!*

loss_1$єўBЪ,       ШС	h"Шє]жA"*

loss_1ЬЂьB09БI       ШС	)Щє]жA#*

loss_18DC7№Ье       ШС	жтЩє]жA$*

loss_1Э`яB1:жэ       ШС	УМЪє]жA%*

loss_1­sќBљср       ШС	xГЫє]жA&*

loss_1aєBк?З%       ШС	оЌЬє]жA'*

loss_1ФѓBHH        ШС	Эє]жA(*

loss_1іКёBѓЬш       ШС	B]Ює]жA)*

loss_1ыЎшBя`z       ШС	@4Яє]жA**

loss_1}7ђB@м       ШС	ьає]жA+*

loss_16июBU9       ШС	9юає]жA,*

loss_1о`№BГd7       ШС	Пбє]жA-*

loss_1ѓB5b       ШС	-Авє]жA.*

loss_1ЦЖєBEЃV       ШС	?гє]жA/*

loss_1яBKф       ШС	Ёfдє]жA0*

loss_1пEюBі        ШС	&4еє]жA1*

loss_1ЊышBЛ=Мј       ШС	жє]жA2*

loss_1В`сBHОї       ШС	Cужє]жA3*

loss_1ьшB1       ШС	ЊЗзє]жA4*

loss_1хBэЪIK       ШС	;иє]жA5*

loss_1 ухBш Јф       ШС	єйє]жA6*

loss_13xхB4;э       ШС	rкє]жA7*

loss_1роBИa       ШС	ШAлє]жA8*

loss_1C}эBaС       ШС	"мє]жA9*

loss_1ћтB№В!       ШС	Етмє]жA:*

loss_1кBЋФѓ       ШС	№мнє]жA;*

loss_1mЋеB&В=       ШС	hьоє]жA<*

loss_1ЕъиBj$       ШС	лпє]жA=*

loss_1аќбBeлІ       ШС	}шрє]жA>*

loss_1}ЂеBZићЭ       ШС	птсє]жA?*

loss_1pLЦBЇU$*       ШС	уртє]жA@*

loss_1ФПЭB+
       ШС	/оує]жAA*

loss_1огBWAB       ШС	Mмфє]жAB*

loss_1
tЭBцџ"       ШС	охє]жAC*

loss_1xЮBЋчv       ШС	тЬцє]жAD*

loss_1ожBЯ7вЎ       ШС	=шє]жAE*

loss_1>њкBJvжd       ШС	Rѓшє]жAF*

loss_161ЦBуr       ШС	Iзщє]жAG*

loss_1*шЧB ZЫ       ШС	оЫъє]жAH*

loss_1AqСBпЏт       ШС	СЇыє]жAI*

loss_1 zЬBЌьxP       ШС	с|ьє]жAJ*

loss_1/СУBS`ГЯ       ШС	ц[эє]жAK*

loss_1Њ#ХBј"       ШС	.Sює]жAL*

loss_1блдB=sРН       ШС	P6яє]жAM*

loss_1SИBШLЇ       ШС	'№є]жAN*

loss_1$KЋBIќ        ШС	фі№є]жAO*

loss_1џjЧBшSO       ШС	Бсёє]жAP*

loss_1nБBiGм       ШС	Гђє]жAQ*

loss_1ЋаСB№ є(       ШС	Cѓє]жAR*

loss_1гxМBEс       ШС	і_єє]жAS*

loss_1ф3РBлЇ       ШС	jNѕє]жAT*

loss_1auОBэЕє       ШС	1іє]жAU*

loss_1>9ЕB0g,       ШС	џїє]жAV*

loss_1ЌЊBк З       ШС	ўеїє]жAW*

loss_1ІЗBDGЊџ       ШС	KЋјє]жAX*

loss_1ЏBоЃ|       ШС	ѕљє]жAY*

loss_1шіЎBН%Э]       ШС	і]њє]жAZ*

loss_14пЩByрd       ШС	3ћє]жA[*

loss_1#БBBћШ       ШС	M2ќє]жA\*

loss_1^mB@Rк       ШС	r§є]жA]*

loss_1-йІBчГ­       ШС	№§є]жA^*

loss_1VЈBEZ?/       ШС	%Ъўє]жA_*

loss_1p
ЃBFf       ШС	Zџє]жA`*

loss_1ЌBUН       ШС	ћt є]жAa*

loss_1wFЅBКВЬ       ШС	ѕHє]жAb*

loss_1§ІBAлу       ШС	М є]жAc*

loss_1Ц_ИBcу,       ШС	є]жAd*

loss_1BH       ШС	+ћє]жAe*

loss_1лBpЩТ       ШС	чџє]жAf*

loss_1ѓ5ЈBш &       ШС	юює]жAg*

loss_1цЅBа)	       ШС	№оє]жAh*

loss_1З	Bm%       ШС	гє]жAi*

loss_15Ц BхЁ[є       ШС	ЦОє]жAj*

loss_1јЉBЧ!0       ШС	SЏ	є]жAk*

loss_1ЬїB!`:       ШС	СЊ
є]жAl*

loss_1sjBРб\i       ШС	еДє]жAm*

loss_1яџB?т       ШС	иЖє]жAn*

loss_1mBA,P       ШС	Х­є]жAo*

loss_1сBСХ       ШС	pє]жAp*

loss_1	пBcг       ШС	zє]жAq*

loss_1wЂB(&ф       ШС	Џ`є]жAr*

loss_1?B/Zм       ШС	sGє]жAs*

loss_1`!BM"       ШС	Eє]жAt*

loss_1fэЊBr|н       ШС	$(є]жAu*

loss_1DаBqЇW       ШС	8є]жAv*

loss_1+ИB]Х       ШС	Rє]жAw*

loss_1FЦBk<вЦ       ШС	Tрє]жAx*

loss_1&BЎЫZ       ШС	ШЕє]жAy*

loss_1бB$	       ШС	lє]жAz*

loss_10BЯ>P	       ШС	Zbє]жA{*

loss_1mBL6С       ШС	.Vє]жA|*

loss_1к&Bјяс<       ШС	,Eє]жA}*

loss_17ВBDеe       ШС	uє]жA~*

loss_1нBћўE[       ШС	Іяє]жA*

loss_1УжBві=и       `/п#	Мє]жA*

loss_1фBl]О       `/п#	Дє]жA*

loss_1DBдРп       `/п#	ёfє]жA*

loss_1цLBЬeѓ       `/п#	4є]жA*

loss_1DJBnј'       `/п#	o+ є]жA*

loss_1ёBбѕ       `/п#	?!є]жA*

loss_19ЁBѓ9x       `/п#	Пє!є]жA*

loss_1ЊlBЛ       `/п#	ЋЬ"є]жA*

loss_1Ж
B        `/п#	ў#є]жA*

loss_1АќBѓ&Р       `/п#	Cs$є]жA*

loss_1qвB,`е       `/п#	J%є]жA*

loss_1ІбBаCВћ       `/п#	i&є]жA*

loss_1С{BЫ!J       `/п#	'є]жA*

loss_1СрBмtбЄ       `/п#	(є]жA*

loss_12чB,мР       `/п#	Iл(є]жA*

loss_1ИмBйџLВ       `/п#	uЌ)є]жA*

loss_1$ІBнэЈ       `/п#	І*є]жA*

loss_1BиBгЂ~-       `/п#	НU+є]жA*

loss_10TBнj       `/п#	1%,є]жA*

loss_1^чBЎЕo%       `/п#	§,є]жA*

loss_1С<hBPьЋ       `/п#	4ї-є]жA*

loss_1ЬBжR       `/п#	р.є]жA*

loss_1ьДhBW^X