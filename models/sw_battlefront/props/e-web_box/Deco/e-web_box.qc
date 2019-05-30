// Created by Crowbar 0.34.0.0

$ModelName "SW_Battlefront\props\e-web\e-web_box.mdl"

$BodyGroup "e-web"
{
	studio "e-web_box_reference.smd"
}


$SurfaceProp "metal"

$Contents "solid"

$MaxEyeDeflection 90

$MostlyOpaque

$CDMaterials "models\SW_Battlefront\Weapons\emplacement\"

$CBox 0 0 0 0 0 0

$BBox -14.482 -1.618 -2.941 18.259 1.618 5.263


$Sequence "idle" {
	"e-web_box_anims\idle.smd"
	activity "ACT_DIERAGDOLL" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$CollisionModel "e-web_box_physics.smd"
{
	$mass 70
	$inertia 3
	$damping 0
	$rotdamping 0

}
