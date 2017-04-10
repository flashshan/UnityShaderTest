using UnityEngine;
using System.Collections;
using System.Linq;

public class CheckVertex : MonoBehaviour {

    public MeshFilter mh;
	// Use this for initialization
	void Start () {
        mh = this.GetComponent<MeshFilter>();
        
        Vector3[] verts = mh.mesh.vertices;
        float max = verts.Max(v => v.x);
        float min = verts.Min(v => v.x);
        Debug.Log(max + " " + min);
 

	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
