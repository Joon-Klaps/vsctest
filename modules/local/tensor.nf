
process TENSOR {
    tag "$meta.id"
    label 'process_single'

    module "TensorFlow/2.15.1-foss-2023a"

    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta), path("*.info"), emit: info

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    python3 <<EOF > ${meta.id}_tf.info
    import tensorflow as tf
    print("TensorFlow version:", tf.__version__)
    print("GPU available:", tf.test.is_gpu_available())
    EOF
    """

}
