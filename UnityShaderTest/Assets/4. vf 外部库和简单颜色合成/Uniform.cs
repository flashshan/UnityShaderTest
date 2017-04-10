using UnityEngine;
using System.Collections;

public class Uniform : MonoBehaviour {

	// Use this for initialization
	void Start () {
        GetComponent<Renderer>().material.SetVector("_SecondColor", new Vector4(1,0,0,1));
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
