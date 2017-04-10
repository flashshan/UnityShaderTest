using UnityEngine;
using System.Collections;

public class test : MonoBehaviour {

    int a;
	// Use this for initialization
	void Start () {
        a = 0;
	}
	
	// Update is called once per frame
	void Update () {
        a++;
        float rad = (float)(a/180.0 * Mathf.PI);
        Matrix4x4 ro = new Matrix4x4();
        ro[0, 0] = Mathf.Cos(rad);
        ro[0, 2] = Mathf.Sin(rad);
        ro[1, 1] = 1;
        ro[2, 0] = -Mathf.Sin(rad);
        ro[2, 2] = Mathf.Cos(rad);
        ro[3, 3] = 1;

        GetComponent<Renderer>().material.SetMatrix("ro", ro);

        Matrix4x4 sm = new Matrix4x4();
        sm[0, 0] = Mathf.Sin(rad) / 2 + 0.5f;
        sm[1, 1] = Mathf.Cos(rad) / 4 + 0.5f;
        sm[2, 2] = Mathf.Sin(rad) / 8 + 0.5f;
        sm[3, 3] = 1;

        GetComponent<Renderer>().material.SetMatrix("sm", sm);

        transform.Rotate(new Vector3(0, 0.5f, 0.5f));
	}
}
