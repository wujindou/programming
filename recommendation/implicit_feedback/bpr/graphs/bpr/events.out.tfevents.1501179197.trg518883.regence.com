       ЃK"	  @O^жAbrain.Event:2!Ъщ       Kp	>KO^жA"ѓЇ
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
 *шЁ>
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2в	*
seedБџх)*
_output_shapes
:	
*
dtype0*
T0

variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	
*
T0

variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	
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
 *шЁ>
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2в	*
seedБџх)*
_output_shapes
:	э
*
dtype0*
T0
Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	э
*
T0

variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	э
*
T0

variables/user_factors
VariableV2*
_output_shapes
:	
*
dtype0*
shape:	
*
shared_name *
	container 
й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/user_factors*
_output_shapes
:	


variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	
*
T0*)
_class
loc:@variables/user_factors

variables/item_factors
VariableV2*
_output_shapes
:	э
*
dtype0*
shape:	э
*
shared_name *
	container 
л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/item_factors*
_output_shapes
:	э


variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	э
*
T0*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
_output_shapes	
:э*
dtype0*
valueBэ*    

variables/item_bias
VariableV2*
_output_shapes	
:э*
dtype0*
shape:э*
shared_name *
	container 
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
validate_shape(*
T0*
use_locking(*&
_class
loc:@variables/item_bias*
_output_shapes	
:э

variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:э*
T0*&
_class
loc:@variables/item_bias
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0*
Tparams0
Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0*
Tparams0
Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0*
Tparams0
В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0*
Tparams0
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0*
Tparams0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
\
loss/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :

loss/SumSumloss/mulloss/Sum/reduction_indices*#
_output_shapes
:џџџџџџџџџ*
	keep_dims( *

Tidx0*
T0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/NegNegloss/add*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/ExpExploss/Neg*#
_output_shapes
:џџџџџџџџџ*
T0
Q
loss/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
W

loss/add_1Addloss/add_1/xloss/Exp*#
_output_shapes
:џџџџџџџџџ*
T0
I
loss/LogLog
loss/add_1*#
_output_shapes
:џџџџџџџџџ*
T0
I

loss/Neg_1Negloss/Log*#
_output_shapes
:џџџџџџџџџ*
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
:џџџџџџџџџ
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
з#<
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
:џџџџџџџџџ
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
з#<
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
:џџџџџџџџџ*
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
:џџџџџџџџџ
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
з#<
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
:џџџџџџџџџ*
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
 *  ?
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
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Љ
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

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
ы
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
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape
ы
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
О
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
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ
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
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
ы
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
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*#
_output_shapes
:џџџџџџџџџ*
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
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
ы
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
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
ы
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
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
ы
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
О
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
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:џџџџџџџџџ*
T0
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
Т
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
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

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
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
ы
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
О
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
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
Т
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
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

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
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
h
#gradients/loss/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
ы
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
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:џџџџџџџџџ
*
T0
b
gradients/loss/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
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
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*'
_output_shapes
:џџџџџџџџџ
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

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
у
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
Т
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
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

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
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
h
#gradients/loss/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
ы
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
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*'
_output_shapes
:џџџџџџџџџ
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

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*#
_output_shapes
:џџџџџџџџџ*
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
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*'
_output_shapes
:џџџџџџџџџ
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

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
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
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Ы
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
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
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

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
Ж
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

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:џџџџџџџџџ*
N*
T0
c
!gradients/loss/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:џџџџџџџџџ*
T0

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0

'gradients/loss/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:э*&
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
Х
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

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ѕ
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
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0

'gradients/loss/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:э*&
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
Х
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

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ѕ
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
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0

gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
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
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0*
T0
Y
gradients/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0*
T0
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0

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
­
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
џ
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
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*
Tshape0
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0
Щ
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
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0

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
Й
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

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
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*
Tshape0
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0

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
Й
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

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
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*
Tshape0
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Y
gradients/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
N*

Tidx0*
T0
Y
gradients/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0*
T0
b
GradientDescent/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *ЭЬЬ=
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*)
_class
loc:@variables/user_factors
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
_output_shapes
:	
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/user_factors
б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*)
_class
loc:@variables/item_factors

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
_output_shapes
:	э
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/item_factors
М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:џџџџџџџџџ*
T0*&
_class
loc:@variables/item_bias

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
_output_shapes	
:э*
T0*
Tindices0*
use_locking( *&
_class
loc:@variables/item_bias
Х
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
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign";Ц"     №	m`O^жAJЙХ
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
Ttype*1.1.02v1.1.0-rc0-61-g1ec6ed5ѓЇ
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
 *шЁ>
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2в	*
seedБџх)*
dtype0*
T0*
_output_shapes
:	


variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	
*
T0

variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	
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
 *шЁ>
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2в	*
seedБџх)*
dtype0*
T0*
_output_shapes
:	э

Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	э
*
T0

variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	э
*
T0

variables/user_factors
VariableV2*
_output_shapes
:	
*
dtype0*
shape:	
*
shared_name *
	container 
й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/user_factors*
_output_shapes
:	


variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	
*
T0*)
_class
loc:@variables/user_factors

variables/item_factors
VariableV2*
_output_shapes
:	э
*
dtype0*
shape:	э
*
shared_name *
	container 
л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
validate_shape(*
T0*
use_locking(*)
_class
loc:@variables/item_factors*
_output_shapes
:	э


variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	э
*
T0*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
_output_shapes	
:э*
dtype0*
valueBэ*    

variables/item_bias
VariableV2*
_output_shapes	
:э*
dtype0*
shape:э*
shared_name *
	container 
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
validate_shape(*
T0*
use_locking(*&
_class
loc:@variables/item_bias*
_output_shapes	
:э

variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:э*
T0*&
_class
loc:@variables/item_bias
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0*
Tparams0
Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0*
Tparams0
Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0*
Tparams0
В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0*
Tparams0
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0*
Tparams0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
\
loss/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :

loss/SumSumloss/mulloss/Sum/reduction_indices*#
_output_shapes
:џџџџџџџџџ*
	keep_dims( *

Tidx0*
T0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/NegNegloss/add*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/ExpExploss/Neg*#
_output_shapes
:џџџџџџџџџ*
T0
Q
loss/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
W

loss/add_1Addloss/add_1/xloss/Exp*#
_output_shapes
:џџџџџџџџџ*
T0
I
loss/LogLog
loss/add_1*#
_output_shapes
:џџџџџџџџџ*
T0
I

loss/Neg_1Negloss/Log*#
_output_shapes
:џџџџџџџџџ*
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
:џџџџџџџџџ
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
з#<
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
:џџџџџџџџџ
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
з#<
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
:џџџџџџџџџ*
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
:џџџџџџџџџ
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
з#<
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
:џџџџџџџџџ*
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
 *  ?
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
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Љ
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

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
ы
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
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape
ы
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
О
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
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ
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
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
ы
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
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*#
_output_shapes
:џџџџџџџџџ*
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
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
ы
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
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
ы
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
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
_output_shapes
: *
T0*
Tshape0

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
ы
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
О
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
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:џџџџџџџџџ*
T0
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
Т
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
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

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
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
_output_shapes
: *
T0*
Tshape0

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
ы
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
О
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
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*
T0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
Т
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
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

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
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
h
#gradients/loss/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
ы
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
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
_output_shapes
: *
T0*
Tshape0
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *
T0*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:џџџџџџџџџ
*
T0
b
gradients/loss/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
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
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*'
_output_shapes
:џџџџџџџџџ
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

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
у
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
Т
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
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

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
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
h
#gradients/loss/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
ы
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
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*'
_output_shapes
:џџџџџџџџџ
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

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*#
_output_shapes
:џџџџџџџџџ*
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
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  ?
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*'
_output_shapes
:џџџџџџџџџ
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

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
_output_shapes
: *
T0*
Tshape0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *
T0*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
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
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Ы
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
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
T0*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*
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

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
Ж
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

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:џџџџџџџџџ*
N*
T0
c
!gradients/loss/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:џџџџџџџџџ*
T0

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
_output_shapes
:*
T0*
Tshape0
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*
T0*'
_output_shapes
:џџџџџџџџџ

ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0

'gradients/loss/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:э*&
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
Х
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

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ѕ
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
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0

'gradients/loss/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:э*&
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
Х
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

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
Ѕ
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
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0

gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
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
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0*
T0
Y
gradients/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0*
T0
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0

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
­
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
џ
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
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*
Tshape0
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
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
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
_output_shapes
:*
	keep_dims( *

Tidx0*
T0
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0
Щ
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
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*'
_output_shapes
:џџџџџџџџџ
*
T0*
Tshape0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*
T0*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0

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
Й
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

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
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*
Tshape0
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0

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
Й
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

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
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
_output_shapes
:*
N*

Tidx0*
T0
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*
Tshape0
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*#
_output_shapes
:џџџџџџџџџ*
T0*
Tshape0
Y
gradients/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
N*

Tidx0*
T0
Y
gradients/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0*
T0
b
GradientDescent/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *ЭЬЬ=
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*)
_class
loc:@variables/user_factors
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
_output_shapes
:	
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/user_factors
б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0*)
_class
loc:@variables/item_factors

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
_output_shapes
:	э
*
T0*
Tindices0*
use_locking( *)
_class
loc:@variables/item_factors
М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:џџџџџџџџџ*
T0*&
_class
loc:@variables/item_bias

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
_output_shapes	
:э*
T0*
Tindices0*
use_locking( *&
_class
loc:@variables/item_bias
Х
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
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign""
	variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0"
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


loss_1:0ЬJ!       и-	кфbO^жA*

loss_1ЙCєЅ       ШС	gжcO^жA*

loss_1vрCBTшњ       ШС	GЋdO^жA*

loss_1vЏCЎYІ`       ШС	$}eO^жA*

loss_1b&	CнЋ9       ШС	LfO^жA*

loss_1ђв
CЃБ        ШС	 &gO^жA*

loss_1t	C^ACс       ШС	яgO^жA*

loss_1&'C       ШС	ЬhO^жA*

loss_1ICOKЩy       ШС	њiO^жA*

loss_1Т]	CЮНОP       ШС	БjO^жA	*

loss_1(=CТsј       ШС	hkO^жA
*

loss_1r+C[ЕТ       ШС	F?lO^жA*

loss_1дSCуyЎ$       ШС	nmO^жA*

loss_1I0C3хЌк       ШС	ЇщmO^жA*

loss_1ІCЊyЬ       ШС	ВМnO^жA*

loss_1qtCrЦV       ШС	њoO^жA*

loss_1ђ­CDш       ШС	"ppO^жA*

loss_1ЋCАЉt       ШС	Ђ`qO^жA*

loss_1рЭўBЭЪб       ШС	e4rO^жA*

loss_1CLIы       ШС		sO^жA*

loss_1аЗCp\ш       ШС	ІгsO^жA*

loss_1CЄCУ9A       ШС	тБtO^жA*

loss_1ЩMCz\E       ШС	'СuO^жA*

loss_1vCqМрС       ШС	фvO^жA*

loss_1м:Cpзъ       ШС	EwO^жA*

loss_1Х$ClЬя       ШС	cxO^жA*

loss_1ЌўBоЭем       ШС	29yO^жA*

loss_1c3њB_(Џк       ШС	СzO^жA*

loss_1RіC ЗЎB       ШС	ц{O^жA*

loss_1VЇCЧ
Пq       ШС	м{O^жA*

loss_1DR CGtЃш       ШС	FБ|O^жA*

loss_1ь(§B	Рl       ШС	V}O^жA*

loss_1Цq CРKр       ШС	_~O^жA *

loss_1ѓBvЛЂ       ШС	FO^жA!*

loss_1)њBvђё       ШС	ЙO^жA"*

loss_1g|љBГ,У       ШС	єO^жA#*

loss_1ЈC CДИ       ШС	еO^жA$*

loss_1:їBщНюЬ       ШС	yАO^жA%*

loss_1{рјBBЯГѓ       ШС	зO^жA&*

loss_1ДяBщр       ШС	ПeO^жA'*

loss_1lјBсIэ       ШС	эDO^жA(*

loss_1]№B
кcЧ       ШС	]6O^жA)*

loss_1:ѓBІ{Hc       ШС	O^жA**

loss_1LјBЌ>Р       ШС	вуO^жA+*

loss_1оћѓBЁ       ШС	EИO^жA,*

loss_1ЛюB       ШС	CO^жA-*

loss_1S;щBзВл:       ШС	ЧfO^жA.*

loss_1уBмAю       ШС	С8O^жA/*

loss_1 ЊшBфy№       ШС	^O^жA0*

loss_1{mшBWФМ       ШС	
јO^жA1*

loss_1PіB:Ц,B       ШС	бO^жA2*

loss_1LGъBcНР       ШС	ДАO^жA3*

loss_1@фB[Лx       ШС	/O^жA4*

loss_1дyцBG{С7       ШС	Ш_O^жA5*

loss_1ЙАдBоЋХ)       ШС	8O^жA6*

loss_1VьBёgЈf       ШС	O^жA7*

loss_1cкфBжЕa       ШС	aнO^жA8*

loss_1јяBеў7       ШС	УO^жA9*

loss_1*CнB}ПJЬ       ШС	КЃO^жA:*

loss_1тB:ђпЦ       ШС	}O^жA;*

loss_1@'вBv+)       ШС	НRO^жA<*

loss_1>гBЄp       ШС	У,O^жA=*

loss_1лњнBшЏЧ       ШС	нO^жA>*

loss_1[юЭBmъІ       ШС	ьйO^жA?*

loss_1рпB#в+       ШС	УЗO^жA@*

loss_1q?жBЫ6;Ќ       ШС	§ЁO^жAA*

loss_1ЭєгBдР        ШС	н|O^жAB*

loss_1В+ЯBЎ<М       ШС	ьOO^жAC*

loss_1ZаB7№       ШС	d$O^жAD*

loss_1ьнЫB&§w'       ШС	ќO^жAE*

loss_1fжB}xЌћ       ШС	ЛаO^жAF*

loss_1(ЧB3"hW       ШС	лЇO^жAG*

loss_1ЭУBvQ/З       ШС	Џ| O^жAH*

loss_1ЭХBћ]Л<       ШС	aЁO^жAI*

loss_1rЯЦBВўKл       ШС	<ЂO^жAJ*

loss_1\xЭBМj/Я       ШС	ЃO^жAK*

loss_1И3ШBѕ)m       ШС	nоЃO^жAL*

loss_1UСB@j2        ШС	ЕЄO^жAM*

loss_1CПBУ­Ъ       ШС	ЅO^жAN*

loss_1:iУBю       ШС	_ІO^жAO*

loss_1єФBш       ШС	}<ЇO^жAP*

loss_1мKМB7СЫН       ШС	|(ЈO^жAQ*

loss_1ќ,ЖBўЃшЃ       ШС	]ўЈO^жAR*

loss_1nСB"VНћ       ШС	-ЯЉO^жAS*

loss_1їХBиcвЋ       ШС	YЂЊO^жAT*

loss_1ЫИBЌв       ШС	tЋO^жAU*

loss_1вВByР!       ШС	ZЌO^жAV*

loss_1аЏBф&З       ШС	31­O^жAW*

loss_1Ћ ЧB2эўg       ШС	& ЎO^жAX*

loss_1ЇЎBЏZЛR       ШС	рЎO^жAY*

loss_1ъџ­BШ1a       ШС	gИЏO^жAZ*

loss_1цcГB\9*Л       ШС	­АO^жA[*

loss_1йЏBђА       ШС	М\БO^жA\*

loss_1hЈBrмT       ШС	х+ВO^жA]*

loss_1ИЄB`г       ШС	ьћВO^жA^*

loss_1нюЋBя+єГ       ШС	ЂаГO^жA_*

loss_1рnЃBYRђ       ШС	xЖДO^жA`*

loss_1ZBЪg       ШС	-ДЕO^жAa*

loss_1І­BjЪ{       ШС	MЖO^жAb*

loss_1;ЏЁBЮюѓ       ШС	.XЗO^жAc*

loss_1СbЇB+Њm       ШС	О/ИO^жAd*

loss_1ЊЂB!­       ШС	ЙO^жAe*

loss_1qМB}Р~       ШС	DмЙO^жAf*

loss_1~=BІ[       ШС	ККO^жAg*

loss_1ЋBнћ?љ       ШС	ЛO^жAh*

loss_1yАBшЧ=        ШС	МO^жAi*

loss_1жJЅBй№       ШС	ДZНO^жAj*

loss_1ћBЂ№ЧЄ       ШС	I,ОO^жAk*

loss_1п%BШgј#       ШС	џОO^жAl*

loss_16B>${a       ШС	xгПO^жAm*

loss_1BЉ7Љ       ШС	ЊРO^жAn*

loss_1#wBЕФЙЌ       ШС	д|СO^жAo*

loss_1лBџe        ШС	vPТO^жAp*

loss_1aBлфbР       ШС	d>УO^жAq*

loss_1NЄB2I>ш       ШС	oФO^жAr*

loss_1КBА#D1       ШС	нФO^жAs*

loss_1НBгa?Y       ШС	<МХO^жAt*

loss_1цЁBxL,       ШС	LЦO^жAu*

loss_1BED~       ШС	ОgЧO^жAv*

loss_1ЕFBtХк       ШС	ФCШO^жAw*

loss_1ЫкB,O0       ШС	B!ЩO^жAx*

loss_19BьК­є       ШС	ю#ЪO^жAy*

loss_1н&ЁB,Ш9       ШС	фїЪO^жAz*

loss_1N­BЛЌ       ШС	дЫO^жA{*

loss_1дЌBЁВё       ШС	ћ­ЬO^жA|*

loss_1MBйД       ШС	ЄЭO^жA}*

loss_1іgBзн       ШС	­jЮO^жA~*

loss_1\B>        ШС	є6ЯO^жA*

loss_10ЉBљWGм       `/п#	#аO^жA*

loss_1ьBиG       `/п#	vћаO^жA*

loss_1Ъ0BJ0У       `/п#	МЬбO^жA*

loss_15ЙЅBЭЫе       `/п#	{ЁвO^жA*

loss_1hBѓ№9       `/п#	їwгO^жA*

loss_1PnByI<;       `/п#	ПFдO^жA*

loss_15yBК8       `/п#	№еO^жA*

loss_1дBLTм       `/п#	5ьеO^жA*

loss_1яqB@$ЧФ       `/п#	ФжO^жA*

loss_1<Bщ(2Ц       `/п#	ЄЋзO^жA*

loss_1QB0Ъ       `/п#	$иO^жA*

loss_1UщBZхз       `/п#	уUйO^жA*

loss_1R{vB1Њ       `/п#	#.кO^жA*

loss_1еBЇ~Ч       `/п#	uлO^жA*

loss_1ёmB|Ў       `/п#	ЧзлO^жA*

loss_1XB|Џђ       `/п#	\ЌмO^жA*

loss_1BЂжеb       `/п#	энO^жA*

loss_14пzBІeKэ       `/п#	rоO^жA*

loss_1BяЫ       `/п#	ЬDпO^жA*

loss_1ј;wBkм       `/п#	рO^жA*

loss_1љ9BU9Т       `/п#	tэрO^жA*

loss_1,xtBlэЛ       `/п#	ьОсO^жA*

loss_1HB{;